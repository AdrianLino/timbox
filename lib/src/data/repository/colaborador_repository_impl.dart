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
        print('si se pudo $data');
        return Success(data);
      } else {
        final error = json.decode(response.body);
        print('no se que paso ${error["error"]}');
        return Error(error["error"] ?? "Error desconocido");
      }
    } catch (e) {
      print('errorrrrrrrrrrrr' + e.toString());
      return Error("Error al conectar con el servidor: $e");
    }
  }

}
