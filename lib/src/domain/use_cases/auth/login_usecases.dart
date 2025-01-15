

import '../../repository/auth_repository.dart';

class LogininUseCase {
  AuthRepository _authRepository;

  LogininUseCase(this._authRepository);

  launch({required String email, required String password}) =>
      _authRepository.login(email, password);
}
