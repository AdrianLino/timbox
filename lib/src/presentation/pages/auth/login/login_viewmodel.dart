import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:timbox/src/presentation/pages/auth/login/login_state.dart';

import '../../../../domain/use_cases/auth/auth_usecases.dart';
import '../../../../domain/utils/resource.dart';
import '../../utils/validation_item.dart';


class LoginViewModel extends ChangeNotifier{

  LoginState _state = LoginState();
//States
  LoginState get state => _state;

  //es la mejor forma de comunicar el estado de la peticion
  StreamController<Resource> _responsecontroller = StreamController<Resource>();
  Stream<Resource> get response => _responsecontroller.stream;

  LoginState get getState => _state;



  AuthUseCases _authUseCases;

  LoginViewModel(this._authUseCases);



  void login() async{
    if(state.isValid()){
      _responsecontroller.add(Loading()); //esperando la respuesta
      final data =await _authUseCases.login.launch(
          email: _state.email.value,
          password: _state.password.value
      );
      _responsecontroller.add(data);
    }
  }

  void ChangeEmail(String value) {
    _responsecontroller.add(Init());
    final bool emailFormatValid =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);

    if (!emailFormatValid) {
      _state = _state.copyWith(email: ValidationItem(error: 'No es un email'));
    }
    else if (value.length >= 6 ) {
      _state = _state.copyWith(email: ValidationItem(value: value, error: ''));
    }

    else {
      _state = _state.copyWith(email: ValidationItem(error: 'Al menos 6 caracteres'));
    }

    notifyListeners();
  }

  void ChangePassword(String value){
    _responsecontroller.add(Init());
    if(value.length >= 6) {
      _state = _state.copyWith(
          password: ValidationItem(value: value, error: '')
      );
    }else{
      _state = _state.copyWith(
        password: ValidationItem(error: 'La contrast debe tener al menos 6 caracteres'),
      );
    }

    notifyListeners();
  }

}