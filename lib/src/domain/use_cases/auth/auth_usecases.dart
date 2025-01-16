
import 'package:timbox/src/domain/use_cases/auth/register_usercases.dart';
import 'package:timbox/src/domain/use_cases/auth/update_password_usecase.dart';

import 'login_usecases.dart';
import 'lost_pasword_usecases.dart';

class AuthUseCases {

  LogininUseCase login;
  RegisterUseCase register;
  LostPasswordUseCase lostPassword;
  UpdatePasswordUseCase updatePassword;

  AuthUseCases({
    required this.login,
    required this.register,
    required this.lostPassword,
    required this.updatePassword,
  });

}