import '../../repository/auth_repository.dart';

class LostPasswordUseCase {

  final AuthRepository _authRepository;

  LostPasswordUseCase(this._authRepository);

  launch({required String email, required String rfc}) async {
    return await _authRepository.lostPassword(email, rfc);
  }

}