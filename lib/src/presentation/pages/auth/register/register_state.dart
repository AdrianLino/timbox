


import '../../../../domain/models/personas_data.dart';
import '../../utils/validation_item.dart';

class RegisterState {

  ValidationItem email;
  ValidationItem password;
  ValidationItem username;
  ValidationItem confirmPassword;
  ValidationItem rfc;

  RegisterState({
    this.email = const ValidationItem(),
    this.password = const ValidationItem(),
    this.username = const ValidationItem(),
    this.confirmPassword = const ValidationItem(),
    this.rfc = const ValidationItem(),
  });

  toUser() => PersonasData(
    nombre: this.username.value,
    correo: this.email.value,
    rfc: this.rfc.value,
    password: this.confirmPassword.value,
  );


    bool isValid() {
      if (email.value.isNotEmpty &&
          email.error.isEmpty &&
          password.value.isNotEmpty &&
          password.error.isEmpty &&
          username.value.isNotEmpty &&
          username.error.isEmpty &&
          confirmPassword.value.isNotEmpty &&
          confirmPassword.error.isEmpty &&
          password.value == confirmPassword.value &&
          rfc.value.isNotEmpty &&
          rfc.error.isEmpty

      ) {
        return true;
      } else {
        return false;
      }
    }

    RegisterState copyWith({
      ValidationItem? email,
      ValidationItem? password,
      ValidationItem? username,
      ValidationItem? confirmPassword,
      ValidationItem? rfc,
    }) =>
        RegisterState(
          email: email ?? this.email,
          password: password ?? this.password,
          username: username ?? this.username,
          confirmPassword: confirmPassword ?? this.confirmPassword,
          rfc: rfc ?? this.rfc,
        );


}