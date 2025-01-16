import '../../repository/auth_repository.dart';

class UpdatePasswordUseCase {
  final AuthRepository _authRepository;

  UpdatePasswordUseCase(this._authRepository);

launch({required String email, required String rfc, required String newPassword}) async {
    return await _authRepository.updatePassword(email, rfc, newPassword);
  }
}