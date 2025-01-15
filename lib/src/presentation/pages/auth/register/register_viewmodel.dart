
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timbox/src/presentation/pages/auth/register/register_state.dart';

import '../../../../domain/use_cases/auth/auth_usecases.dart';
import '../../../../domain/utils/resource.dart';
import '../../utils/validation_item.dart';


class RegisterViewModel extends ChangeNotifier{

  RegisterState _state = RegisterState();
  RegisterState get state => _state;

  StreamController<Resource> _responsecontroller = StreamController<Resource>();
  Stream<Resource> get response => _responsecontroller.stream;


  AuthUseCases _authUseCases;
  RegisterViewModel(this._authUseCases);


  register() async{
    if (_state.isValid()) {
      _responsecontroller.add(Loading()); //esperando la respuesta
      final data =await _authUseCases.register.launch(
          _state.toUser()
      );
      _responsecontroller.add(data);

    } else {
      print("El formulario no es valido");
    }
  }

  changeEmail(String value) {
    _responsecontroller.add(Init());
    final bool emailFormatValid =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);

    if (!emailFormatValid) {
      _state = _state.copyWith(email: ValidationItem(error: 'No es un email'));
    }
    else if (value.length >= 6) {
      _state = _state.copyWith(
          email: ValidationItem(value: value, error: '')
      );
    }else{
      _state = _state.copyWith(
          email: ValidationItem(value: value, error: "El email debe de ser de almenos 6 caracteres")
      );
    }
    notifyListeners();
  }

  changeUsername(String value){
    if (value.length >= 3) {
        _state = _state.copyWith(
          username: ValidationItem(value: value, error: '')
      );
    }else{
      _state = _state.copyWith(
          username: ValidationItem(value: value, error: "El nombre de usuario debe ser de almenos 3 caracteres")
      );
    }
    notifyListeners();
  }

  void changerfc(String value) {
    _responsecontroller.add(Init());

    // Expresión regular para validar RFC
    final rfcRegex = RegExp(
        r'^([A-ZÑ&]{3,4})' // 3 o 4 letras iniciales
        r'([0-9]{2})' // Año (2 dígitos)
        r'([0-9]{2})' // Mes (2 dígitos)
        r'([0-9]{2})' // Día (2 dígitos)
        r'([A-Z\d]{3})$'); // Homoclave (3 caracteres alfanuméricos)

    if (value.isEmpty) {
      // RFC vacío
      _state = _state.copyWith(
        rfc: ValidationItem(value: value, error: "El RFC no puede estar vacío"),
      );
    } else if (value.length < 12 || value.length > 13) {
      // Longitud inválida
      _state = _state.copyWith(
        rfc: ValidationItem(
          value: value,
          error: "El RFC debe tener 12 o 13 caracteres",
        ),
      );
    } else if (!rfcRegex.hasMatch(value)) {
      // Formato inválido
      _state = _state.copyWith(
        rfc: ValidationItem(
          value: value,
          error: "El RFC no cumple con el formato válido",
        ),
      );
    } else {
      // RFC válido
      _state = _state.copyWith(
        rfc: ValidationItem(value: value, error: ''),
      );
    }

    // Notificar cambios
    notifyListeners();
  }

  changePassword(String value){
    _responsecontroller.add(Init());

    if (value.length >= 6) {
      _state = _state.copyWith(
          password: ValidationItem(value: value, error: '')
      );
    }else{
      _state = _state.copyWith(
          password: ValidationItem(value: value, error: "La contraseña debe de ser de almenos 6 caracteres")
      );
    }
    notifyListeners();
  }

  changeConfirmPassword(String value){
    _responsecontroller.add(Init());

    if (value.length >= 6) {
      _state = _state.copyWith(
          confirmPassword: ValidationItem(value: value, error: '')
      );
    }else{
      _state = _state.copyWith(
          confirmPassword: ValidationItem(value: value, error: "La contraseña debe de ser de almenos 6 caracteres")
      );
    }
    notifyListeners();
  }
}