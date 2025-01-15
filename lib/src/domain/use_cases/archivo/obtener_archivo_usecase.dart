import '../../repository/archivo_repository.dart';

class ObtenerArchivoUseCase {
  final ArchivoRepository _archivoRepository;

  ObtenerArchivoUseCase(this._archivoRepository);

  launch({required int? userId}) => _archivoRepository.obtenerArchivos(userId);
}