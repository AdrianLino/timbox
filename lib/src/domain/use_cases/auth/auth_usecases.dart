
import 'package:timbox/src/domain/use_cases/auth/register_usercases.dart';

import 'login_usecases.dart';

class AuthUseCases {

  LogininUseCase login;
  RegisterUseCase register;

  AuthUseCases({
    required this.login,
    required this.register
  });

}