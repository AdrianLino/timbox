

import '../../utils/validation_item.dart';

class LoginState{

  ValidationItem email;
  ValidationItem password;

  LoginState({

    this.email = const ValidationItem(),
    this.password = const ValidationItem(),
  });

  LoginState copyWith({
    ValidationItem? email,
    ValidationItem? password,
  }) =>
    LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
    );


  bool isValid() {
    if (email.value.isNotEmpty &&
        email.error.isEmpty &&
        password.value.isNotEmpty &&
        password.error.isEmpty
    ) {
      return true;
    } else {
      return false;
    }
  }

}