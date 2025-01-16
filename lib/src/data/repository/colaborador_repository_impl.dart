import 'package:timbox/src/domain/utils/resource.dart';
import '../../domain/models/colaborador_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/repository/colaborador_repository.dart';





class ColaboradorRepositoryImpl extends ColaboradorRepository {

  final String baseUrl = "https://api-b7rvhqjiya-uc.a.run.app";


  @override
  Future<Resource> colaboradorRegister(ColaboradorData colaborador) async{
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/colaboradorRegister"), // Agrega el endpoint específico
        headers: {"Content-Type": "application/json"},
        body: json.encode(colaborador.toJson()),
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

  @override
  Future<void> deleteColaborador(int colaboradorId) async {
    final url = Uri.parse("$baseUrl/colaboradorDelete/$colaboradorId");
    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception("Error al eliminar colaborador: ${response.body}");
    }
  }









  @override
  Future<List<ColaboradorData>> getColaboradores(int userId) async {
    final url = Uri.parse("$baseUrl/colaboradorList?userId=$userId");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('Archivos obtenidos con éxito');
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ColaboradorData.fromJson(json)).toList();
    } else {
      throw Exception("Error al obtener archivos: ${response.body}");
    }
  }






  @override
  Future<void> updateColaborador(int colaboradorId, ColaboradorData colaborador) async {
    final url = Uri.parse("$baseUrl/colaboradorUpdate/$colaboradorId");
    final bodyToUpdate = colaborador.toJson();
    // OJO: Podrías remover campos que no se actualizan.

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(bodyToUpdate),
    );

    if (response.statusCode != 200) {
      throw Exception("Error al actualizar colaborador: ${response.body}");
    }
  }

}
