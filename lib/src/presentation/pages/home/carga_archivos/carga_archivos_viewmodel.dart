import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../../domain/models/archivos_data.dart';
import '../../../../domain/use_cases/archivo/archivo_usescases.dart';
import '../../../../domain/utils/resource.dart';
import '../../utils/auth_viewmodel.dart';

class ArchivosViewModel extends ChangeNotifier{

  ArchivoUseCases archivoUseCases;

  ArchivosViewModel(this.archivoUseCases);



    Future<Resource> subirArchivo(String nombre) async{
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'pdf'], // Solo XLSX y PDF
    );
    if (result == null || result.files.isEmpty) {
      return Error("No se seleccionó ningún archivo");
    }
    final prefs = await SharedPreferences.getInstance();;
    final savedUserId = prefs.getInt('userId');
    final data = await archivoUseCases.subirArchivo.launch(
        idPersona: savedUserId,
        result: result,
        nombreArchivo: nombre
    );
    return Success('data');
  }

  Future<List<ArchivosData>> obtenerArchivos() async {
    try {
      final prefs = await SharedPreferences.getInstance();;
      final savedUserId = prefs.getInt('userId');
      final archivos = await archivoUseCases.obtenerArchivo.launch(userId: savedUserId);
      return archivos;
    } catch (e) {
      print("Error al obtener archivos: $e");
      rethrow;
    }
  }

}