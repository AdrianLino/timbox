import '../../repository/colaborador_repository.dart';

class GetColaboradorUseCase {
  final ColaboradorRepository _colaboradorRepository;

  GetColaboradorUseCase(this._colaboradorRepository);

  launch({required int idPersona}) async {
    return await _colaboradorRepository.getColaboradores(idPersona);
  }
}