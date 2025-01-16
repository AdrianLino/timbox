import '../../repository/colaborador_repository.dart';

class DeleteColaboradorUseCase {
  final ColaboradorRepository _colaboradorRepository;

  DeleteColaboradorUseCase(this._colaboradorRepository);

  launch({required int colaboradorId}) async {
    await _colaboradorRepository.deleteColaborador(colaboradorId);
  }
}