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



app.post("/colaboradorRegister", async (req, res) => {
  try {
    console.log("Inicio del proceso de registro de colaborador.");
    // Extraer campos del body (mismos nombres que en colaborador.toJson())
    const {
      id_persona,
      nombre,
      correo,
      rfc,
      domicilio_fiscal,
      curp,
      n_seguridad_social,
      fecha_inicio,
      tipo_contrato,
      departamento,
      puesto,
      salario_d,
      salario,
      clave_entidad,
      estado,
    } = req.body;

    console.log("Datos recibidos del cliente:", req.body);

    // Validar que existan todos los campos requeridos
    if (
      !id_persona ||
      !nombre ||
      !correo ||
      !rfc ||
      !domicilio_fiscal ||
      !curp ||
      !n_seguridad_social ||
      !fecha_inicio ||
      !tipo_contrato ||
      !departamento ||
      !puesto ||
      !salario_d ||
      !salario ||
      !clave_entidad ||
      typeof estado === "undefined"
    ) {
      console.log("Error: Faltan campos requeridos.");
      return res.status(400).json({ error: "Todos los campos son requeridos." });
    }
    console.log("Validación de campos requerida completada.");

    // Verificar si correo ya existe
    console.log("Verificando si el correo ya está registrado...");
    const emailQuery = `SELECT * FROM DetallesPersonales WHERE correo = ?`;
    const emailExists = await query(emailQuery, [correo]);
    if (emailExists.length > 0) {
      console.log("Error: El correo ya está registrado.");
      return res.status(400).json({ error: "El correo ya está registrado." });
    }
    console.log("Verificación de correo completada.");

    // Verificar si RFC ya existe
    console.log("Verificando si el RFC ya está registrado...");
    const rfcQuery = `SELECT * FROM DetallesPersonales WHERE rfc = ?`;
    const rfcExists = await query(rfcQuery, [rfc]);
    if (rfcExists.length > 0) {
      console.log("Error: El RFC ya está registrado.");
      return res.status(400).json({ error: "El RFC ya está registrado." });
    }
    console.log("Verificación de RFC completada.");

    // Verificar si CURP ya existe
    console.log("Verificando si la CURP ya está registrada...");
    const curpQuery = `SELECT * FROM DetallesPersonales WHERE curp = ?`;
    const curpExists = await query(curpQuery, [curp]);
    if (curpExists.length > 0) {
      console.log("Error: La CURP ya está registrada.");
      return res.status(400).json({ error: "La CURP ya está registrada." });
    }
    console.log("Verificación de CURP completada.");

    // Insertar el colaborador en la base de datos
    console.log("Insertando colaborador en la base de datos...");
    const insertQuery = `
      INSERT INTO DetallesPersonales (
        id_persona,
        nombre,
        correo,
        rfc,
        domicilio_fiscal,
        curp,
        n_seguridad_social,
        fecha_inicio,
        tipo_contrato,
        departamento,
        puesto,
        salario_d,
        salario,
        clave_entidad,
        id_estado
      )
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    const results = await query(insertQuery, [
      id_persona,
      nombre,
      correo,
      rfc,
      domicilio_fiscal,
      curp,
      n_seguridad_social,
      fecha_inicio, // Debe ser compatible con el formato DATE/DATETIME en MySQL
      tipo_contrato,
      departamento,
      puesto,
      salario_d,
      salario,
      clave_entidad,
      estado,
    ]);
    console.log("Colaborador insertado exitosamente. ID generado:", results.insertId);


    res.status(201).json({
      message: "Colaborador registrado con éxito",
    });
  } catch (error) {
    console.error("Error al registrar el colaborador:", error.message);
    res.status(500).json({ error: "Error interno del servidor." });
  }
});




app.get("/colaboradorList", async (req, res) => {
  try {
    const userId = parseInt(req.query.userId, 10);
    if (!userId) {
      return res.status(400).json({ error: "userId (id_persona) es requerido." });
    }

    const sql = "SELECT * FROM DetallesPersonales WHERE id_persona = ?";
    const results = await query(sql, [userId]);

    return res.status(200).json(results);
  } catch (error) {
    console.error("Error al obtener archivos:", error.message);
    res.status(500).json({ error: "Error interno del servidor." });
  }
});


//actualizar un colaborador
app.put("/colaboradorUpdate/:colaboradorId", async (req, res) => {
  try {
    const { colaboradorId } = req.params;
    // Campos que se permitirán actualizar
    const {
      nombre,
      correo,
      rfc,
      domicilio_fiscal,
      curp,
      n_seguridad_social,
      fecha_inicio,
      tipo_contrato,
      departamento,
      puesto,
      salario_d,
      salario,
      clave_entidad,
    } = req.body;

    // Opcional: podrías validar que NO existan duplicados en correo, RFC y CURP si cambia el valor
    // (similar a lo que haces en el registro).

    const sql = `
      UPDATE DetallesPersonales
      SET
        nombre = ?,
        correo = ?,
        rfc = ?,
        domicilio_fiscal = ?,
        curp = ?,
        n_seguridad_social = ?,
        fecha_inicio = ?,
        tipo_contrato = ?,
        departamento = ?,
        puesto = ?,
        salario_d = ?,
        salario = ?,
        clave_entidad = ?
      WHERE id = ?
      AND id_estado = 1
    `;
    const result = await query(sql, [
      nombre,
      correo,
      rfc,
      domicilio_fiscal,
      curp,
      n_seguridad_social,
      fecha_inicio,
      tipo_contrato,
      departamento,
      puesto,
      salario_d,
      salario,
      clave_entidad,
      colaboradorId,
    ]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: "No se pudo actualizar, colaborador no encontrado." });
    }

    res.status(200).json({
      message: "Colaborador actualizado con éxito"
    });
  } catch (error) {
    console.error("Error al actualizar el colaborador:", error.message);
    res.status(500).json({ error: "Error interno del servidor." });
  }
});



// Eliminar lógicamente un colaborador
app.delete("/colaboradorDelete/:colaboradorId", async (req, res) => {
  try {
    const { colaboradorId } = req.params;

    const sql = `
      UPDATE DetallesPersonales
      SET id_estado = 0
      WHERE id = ?
    `;
    const result = await query(sql, [colaboradorId]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: "No se pudo eliminar, colaborador no encontrado." });
    }

    res.status(200).json({
      message: "Colaborador eliminado (lógica) con éxito"
    });
  } catch (error) {
    console.error("Error al eliminar el colaborador:", error.message);
    res.status(500).json({ error: "Error interno del servidor." });
  }
});








// Exportar la API
exports.api = functions.https.onRequest(app);
