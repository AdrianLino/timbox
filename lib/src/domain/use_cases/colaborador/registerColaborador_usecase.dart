import '../../models/colaborador_data.dart';
import '../../repository/colaborador_repository.dart';

class RegisterColaboradorUseCase {
  final ColaboradorRepository repository;

  RegisterColaboradorUseCase(this.repository);

  launch({required ColaboradorData colaboradorData}) {
    return repository.colaboradorRegister(colaboradorData);
  }
}