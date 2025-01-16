
import '../../models/personas_data.dart';
import '../../repository/auth_repository.dart';

class RegisterUseCase{

  AuthRepository _repository;

  RegisterUseCase(this._repository);

  launch({ required PersonasData user}) => _repository.register(user);
}