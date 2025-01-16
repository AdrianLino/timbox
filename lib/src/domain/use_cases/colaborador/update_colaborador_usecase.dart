import '../../models/colaborador_data.dart';
import '../../repository/colaborador_repository.dart';

class UpdateColaboradorUseCase {
  final ColaboradorRepository _colaboradorRepository;

  UpdateColaboradorUseCase(this._colaboradorRepository);

  launch({required int colaboradorId, required ColaboradorData colaborador}) async {
    await _colaboradorRepository.updateColaborador(colaboradorId, colaborador);
  }
}