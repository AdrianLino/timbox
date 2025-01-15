import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:timbox/src/domain/models/archivos_data.dart';
import 'package:timbox/src/domain/repository/archivo_repository.dart';
import 'package:timbox/src/domain/utils/resource.dart';
import 'package:path/path.dart' as p; // Para extraer extensión si lo deseas
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;



class ArchivoRepositoryImpl implements ArchivoRepository {

  final String baseUrl = "https://api-b7rvhqjiya-uc.a.run.app";



  @override
  Future<bool> editarNombreArchivo(int idArchivo, String nuevoNombre) {
    // TODO: implement editarNombreArchivo
    throw UnimplementedError();
  }

  @override
  Future<bool> eliminarArchivo(int idArchivo) {
    // TODO: implement eliminarArchivo
    throw UnimplementedError();
  }

  @override
  Future<List<ArchivosData>> obtenerArchivos(int? userId) async {
    final url = Uri.parse("$baseUrl/files?userId=$userId");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('Archivos obtenidos con éxito');
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ArchivosData.fromJson(json)).toList();
    } else {
      throw Exception("Error al obtener archivos: ${response.body}");
    }
  }


  @override
  Future<Resource> subirArchivo(int? idPersona, FilePickerResult? result, String nombreArchivo,) async {
    try {
      // 1. Obtener bytes y extensión del archivo
      final fileBytes = result?.files.first.bytes;        // Uint8List?
      final extension = result?.files.first.extension;    // "pdf", "xlsx", etc.

      if (fileBytes == null || extension == null) {
        return Error("No se pudo leer el archivo o la extensión.");
      }

      // 2. Subir a Firebase Storage usando 'putData'
      final fileName = "${DateTime.now().millisecondsSinceEpoch}.$extension";
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("archivos/$fileName");

      // Opcional: definir el content-type apropiado según la extensión:
      String contentType;
      if (extension == 'pdf') {
        contentType = 'application/pdf';
      } else if (extension == 'xlsx') {
        contentType =
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      } else {
        contentType = 'application/octet-stream';
      }

      await storageRef.putData(
        fileBytes,
        firebase_storage.SettableMetadata(contentType: contentType),
      );

      // 3. Obtener la URL de descarga
      final downloadURL = await storageRef.getDownloadURL();

      // 4. Registrar en la base de datos (MySQL), vía tu Cloud Function
      final archivosData = ArchivosData(
        id: 0,             // autoincremental en MySQL
        idPersona: idPersona as int,
        nombre: nombreArchivo,
        extension: extension,
        link: downloadURL,
        fechaCreacion: '', // la DB lo manejará (TIMESTAMP)
      );

      final response = await http.post(
        Uri.parse("$baseUrl/files"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(archivosData.toJson()),
      );

      if (response.statusCode == 201) {
        // Éxito
        print('Archivo registrado con éxito en MySQL');
        return Success("Archivo registrado con éxito en MySQL");
      } else {
        // Error del servidor
        print('Error al registrar archivo: ${response.body}');
        return Error("Error al registrar archivo: ${response.body}");
      }
    } catch (e) {
      // Cualquier excepción en el proceso
      print('Error al subir archivo: $e');
      return Error("Error al subir archivo: $e");
    }
  }
}

// Si tu modelo no tiene un método toJsonString, puedes crearlo así:
extension ArchivosDataExtensions on ArchivosData {
  String toJsonString() {
    final map = toJson();
    return jsonEncode(map);
  }
}
