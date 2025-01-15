import 'package:timbox/src/domain/use_cases/archivo/subir_archivo_usecases.dart';

import 'obtener_archivo_usecase.dart';

class ArchivoUseCases{

  SubirArchivoUseCase subirArchivo;
  ObtenerArchivoUseCase obtenerArchivo;

  ArchivoUseCases({
    required this.subirArchivo,
    required this.obtenerArchivo
  });

}