import 'package:file_picker/file_picker.dart';

import '../../repository/archivo_repository.dart';
import '../../utils/resource.dart';

class SubirArchivoUseCase {
  final ArchivoRepository _archivoRepository;

  SubirArchivoUseCase(this._archivoRepository);

  launch({required int? idPersona, required FilePickerResult? result, required String nombreArchivo}) =>
      _archivoRepository.subirArchivo(idPersona, result, nombreArchivo);
}