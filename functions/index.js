const { onRequest } = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

const functions = require("firebase-functions");
const express = require("express");
const cors = require("cors");
const mysql = require("mysql2");
const rateLimit = require("express-rate-limit");

require("dotenv").config(); // Para usar variables de entorno.

const app = express();
app.use(cors({ origin: true })); // Permitir solicitudes desde el cliente Flutter.
app.use(express.json());

// Configurar la conexión con MySQL
const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
});

const query = (sql, values) =>
    new Promise((resolve, reject) => {
        pool.query(sql, values, (err, results) => {
            if (err) reject(err);
            else resolve(results);
        });
    });

const bcrypt = require("bcrypt"); // Para el hash de contraseñas


// Ruta para registrar usuarios
app.post("/register", async (req, res) => {
    try {
        const { nombre, correo, rfc, password } = req.body;

        if (!nombre || !correo || !rfc || !password) {
            return res.status(400).json({ error: "Todos los campos son requeridos." });
        }

        // Verificar si el correo ya existe
        const emailQuery = `SELECT * FROM Personas WHERE correo = ?`;
        const emailExists = await query(emailQuery, [correo]);

        if (emailExists.length > 0) {
            return res.status(400).json({ error: "El correo ya está registrado." });
        }

        // Verificar si el RFC ya existe
        const rfcQuery = `SELECT * FROM Personas WHERE rfc = ?`;
        const rfcExists = await query(rfcQuery, [rfc]);

        if (rfcExists.length > 0) {
            return res.status(400).json({ error: "El RFC ya está registrado." });
        }

        // Hashear la contraseña antes de almacenarla
        const hashedPassword = await bcrypt.hash(password, 10);

        // Insertar el usuario en la base de datos
        const insertQuery = `
            INSERT INTO Personas (nombre, correo, rfc, password)
            VALUES (?, ?, ?, ?)
        `;
        const results = await query(insertQuery, [nombre, correo, rfc, hashedPassword]);

        // Recuperar el usuario recién creado
        const userId = results.insertId;
        const userQuery = `SELECT * FROM Personas WHERE id = ?`;
        const users = await query(userQuery, [userId]);
        const user = users[0];

        // Generar un token JWT para el usuario
        const jwt = require("jsonwebtoken");
        const token = jwt.sign(
            { userId: user.id, correo: user.correo }, // Datos del token
            process.env.JWT_SECRET, // Clave secreta
            { expiresIn: "1h" } // Duración del token
        );

        // Responder con el token y los datos del usuario
        res.status(201).json({
            message: "Usuario registrado y sesión iniciada con éxito",
            token: token,
            user: {
                id: user.id,
                nombre: user.nombre,
                correo: user.correo,
            },
        });
    } catch (error) {
        console.error("Error al registrar el usuario:", error.message);
        res.status(500).json({ error: "Error interno del servidor." });
    }
});


/*const loginLimiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutos
    max: 3, // Límite de 5 intentos por IP
    message: "Demasiados intentos fallidos. Inténtalo más tarde.",
});*/

//Ruta para el inicio de sesión
app.post("/login", async (req, res) => {
    try {
        const { correo, password } = req.body;

        // Validar que todos los campos estén presentes
        if (!correo || !password) {
            return res.status(400).json({ error: "El correo y la contraseña son requeridos." });
        }

        // Verificar si el correo existe
        const userQuery = `SELECT * FROM Personas WHERE correo = ?`;
        const users = await query(userQuery, [correo]);

        if (users.length === 0) {
            // Respuesta genérica para evitar revelar información
            return res.status(401).json({ error: "Credenciales inválidas." });
        }

        const user = users[0];

        // Comparar la contraseña hash con la enviada
        const isPasswordValid = await bcrypt.compare(password, user.password);

        if (!isPasswordValid) {
            // Respuesta genérica para evitar revelar información
            return res.status(401).json({ error: "Credenciales inválidas." });
        }

        // Si la autenticación es exitosa, generar un token de sesión (por ejemplo, JWT)
        const jwt = require("jsonwebtoken");
        const token = jwt.sign(
            { userId: user.id, correo: user.correo }, // Datos a incluir en el token
            process.env.JWT_SECRET, // Clave secreta
            { expiresIn: "1h" } // Duración del token
        );

        // Responder con el token y/o información del usuario
        res.status(200).json({
            message: "Inicio de sesión exitoso",
            token: token,
            user: {
                id: user.id,
                nombre: user.nombre,
                correo: user.correo,
            },
        });
    } catch (error) {
        console.error("Error en el inicio de sesión:", error.message);
        res.status(500).json({ error: "Error interno del servidor." });
    }
});



// 1. Listar todos los archivos
app.get("/files", async (req, res) => {
  try {
    const userId = parseInt(req.query.userId, 10);
    if (!userId) {
      return res.status(400).json({ error: "userId (id_persona) es requerido." });
    }

    const sql = "SELECT * FROM Archivos WHERE id_persona = ?";
    const results = await query(sql, [userId]);

    return res.status(200).json(results);
  } catch (error) {
    console.error("Error al obtener archivos:", error.message);
    res.status(500).json({ error: "Error interno del servidor." });
  }
});

// 2. Crear un nuevo registro de archivo
app.post("/files", async (req, res) => {
  try {
    const { id_persona, nombre, extension, link } = req.body;

    // Validar campos
    if (!id_persona || !nombre || !extension || !link) {
      return res
        .status(400)
        .json({ error: "Todos los campos son requeridos (id_persona, nombre, extension, link)" });
    }

    const insertQuery = `
      INSERT INTO Archivos (id_persona, nombre, extension, link)
      VALUES (?, ?, ?, ?)
    `;
    await query(insertQuery, [id_persona, nombre, extension, link]);

    res.status(201).json({ message: "Archivo registrado con éxito" });
  } catch (error) {
    console.error("Error al registrar archivo:", error.message);
    res.status(500).json({ error: "Error interno del servidor." });
  }
});

// 3. Editar el nombre de un archivo
app.patch("/files/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const { nombre } = req.body;

    if (!nombre) {
      return res.status(400).json({ error: "El nombre es requerido para actualizar." });
    }

    const updateQuery = `UPDATE Archivos SET nombre = ? WHERE id = ?`;
    await query(updateQuery, [nombre, id]);

    res.status(200).json({ message: "Nombre del archivo actualizado con éxito" });
  } catch (error) {
    console.error("Error al actualizar archivo:", error.message);
    res.status(500).json({ error: "Error interno del servidor." });
  }
});

// 4. Eliminar un archivo
app.delete("/files/:id", async (req, res) => {
  try {
    const { id } = req.params;

    const deleteQuery = `DELETE FROM Archivos WHERE id = ?`;
    await query(deleteQuery, [id]);

    res.status(200).json({ message: "Archivo eliminado con éxito" });
  } catch (error) {
    console.error("Error al eliminar archivo:", error.message);
    res.status(500).json({ error: "Error interno del servidor." });
  }
});



// Exportar la API
exports.api = functions.https.onRequest(app);
