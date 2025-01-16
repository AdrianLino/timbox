import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/models/colaborador_data.dart';
import '../../../../domain/use_cases/colaborador/colaborador_usecases.dart';

class EmpleadosViewmodel extends ChangeNotifier {

  ColaboradorUseCases colaboradorUseCases;


  EmpleadosViewmodel(this.colaboradorUseCases);


  Future<List<ColaboradorData>> obtenerArchivos() async {
    try {
      final prefs = await SharedPreferences.getInstance();;
      final savedUserId = prefs.getInt('userId')!;
      final archivos = await colaboradorUseCases.getColaborador.launch(idPersona: savedUserId);
      print("Archivos: $archivos");
      return archivos;
    } catch (e) {
      print("Error al obtener archivos: $e");
      rethrow;
    }
  }

}
