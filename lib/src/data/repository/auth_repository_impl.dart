import 'package:timbox/src/domain/models/personas_data.dart';
import 'package:timbox/src/domain/utils/resource.dart';

import '../../domain/repository/auth_repository.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepositoryImpl implements AuthRepository {

  final String baseUrl = "https://api-b7rvhqjiya-uc.a.run.app";


  @override
  Future<Resource> login(String correo, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "correo": correo,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        // Intentar decodificar solo si es JSON válido
        if (response.headers['content-type']?.contains('application/json') ?? false) {
          final data = json.decode(response.body);
          return Success(data);
        } else {
          return Error("Respuesta no válida del servidor.");
        }
      } else {
        // Manejar errores del servidor
        final error = json.decode(response.body);
        return Error(error["error"] ?? "Error desconocido");
      }
    } catch (e) {
      return Error("Error al conectar con el servidor: $e");
    }

  }

  @override
  Future<Resource> register(PersonasData user) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"), // Agrega el endpoint específico
        headers: {"Content-Type": "application/json"},
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return Success(data);
      } else {
        final error = json.decode(response.body);
        return Error(error["error"] ?? "Error desconocido");
      }
    } catch (e) {
      return Error("Error al conectar con el servidor: $e");
    }
  }


}