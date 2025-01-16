


import '../../../../domain/models/personas_data.dart';
import '../../utils/validation_item.dart';

class LostPasswordState {

  ValidationItem email;
  ValidationItem rfc;

  LostPasswordState({
    this.email = const ValidationItem(),
    this.rfc = const ValidationItem(),
  });


  bool isValid() {
    if (email.value.isNotEmpty &&
        email.error.isEmpty &&
        rfc.value.isNotEmpty &&
        rfc.error.isEmpty

    ) {
      return true;
    } else {
      return false;
    }
  }

  LostPasswordState copyWith({
    ValidationItem? email,
    ValidationItem? rfc,
  }) =>
      LostPasswordState(
        email: email ?? this.email,
        rfc: rfc ?? this.rfc,
      );


}