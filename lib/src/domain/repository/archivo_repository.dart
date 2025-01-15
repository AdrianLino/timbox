import 'package:file_picker/file_picker.dart';
import 'package:timbox/src/domain/utils/resource.dart';

import '../models/archivos_data.dart';

abstract class ArchivoRepository {
  Future<Resource> subirArchivo(int? idPersona, FilePickerResult? result, String nombreArchivo);
  Future<List<ArchivosData>> obtenerArchivos(int? userId);
  Future<bool> eliminarArchivo(int idArchivo);
  Future<bool> editarNombreArchivo(int idArchivo, String nuevoNombre);
}