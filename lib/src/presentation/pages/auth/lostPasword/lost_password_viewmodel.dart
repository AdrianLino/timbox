import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../../../domain/use_cases/auth/auth_usecases.dart';
import '../../../../domain/utils/resource.dart';
import '../../utils/validation_item.dart';
import '../register/register_state.dart';
import 'lost_password_state.dart';

class LostPasswordViewModel extends ChangeNotifier{


  AuthUseCases _authUseCases;

  LostPasswordViewModel(this._authUseCases);

  LostPasswordState _state = LostPasswordState();
  LostPasswordState get state => _state;

  StreamController<Resource> _responsecontroller = StreamController<Resource>();
  Stream<Resource> get response => _responsecontroller.stream;



  Future<void> ConfirmCredentials(BuildContext context) async {
    if (_state.isValid()) {
      _responsecontroller.add(Loading()); // Esperando la respuesta
      bool data = await _authUseCases.lostPassword.launch(
        email: _state.email.value,
        rfc: _state.rfc.value,
      );

      if (data == true) {
        // Mostrar AlertDialog para ingresar la nueva contraseña
        final controller = TextEditingController();
        await showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Nueva Contraseña"),
              content: TextField(
                controller: controller,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Ingresa tu nueva contraseña",
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(), // Cerrar el diálogo
                  child: Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () async {
                    final newPassword = controller.text.trim();
                    if (newPassword.isNotEmpty) {
                      try {
                        // Llamar a otra función para actualizar la contraseña
                        bool updated = await _authUseCases.updatePassword.launch(
                            email: _state.email.value,
                            rfc: _state.rfc.value,
                            newPassword: newPassword
                        );
                        if (updated) {
                          toastification.show(
                            context: context,
                            title: Text("Éxito"),
                            description: Text("Contraseña actualizada correctamente."),
                            type: ToastificationType.success,
                            autoCloseDuration: Duration(seconds: 3),
                          );
                        } else {
                          toastification.show(
                            context: context,
                            title: Text("Error"),
                            description: Text("No se pudo actualizar la contraseña."),
                            type: ToastificationType.error,
                            autoCloseDuration: Duration(seconds: 3),
                          );
                        }
                      } catch (e) {
                        toastification.show(
                          context: context,
                          title: Text("Error"),
                          description: Text("Ocurrió un error: $e"),
                          type: ToastificationType.error,
                          autoCloseDuration: Duration(seconds: 3),
                        );
                      }
                    } else {
                      toastification.show(
                        context: context,
                        title: Text("Error"),
                        description: Text("La contraseña no puede estar vacía."),
                        type: ToastificationType.error,
                        autoCloseDuration: Duration(seconds: 3),
                      );
                    }
                    Navigator.of(ctx).pop(); // Cerrar el diálogo después de guardar
                  },
                  child: Text("Guardar"),
                ),
              ],
            );
          },
        );
      } else {
        toastification.show(
          context: context,
          title: Text("Error"),
          description: Text("Credenciales inválidas."),
          type: ToastificationType.error,
          autoCloseDuration: Duration(seconds: 3),
        );
      }
    } else {
      toastification.show(
        context: context,
        title: Text("Error"),
        description: Text('Favor de llenar todos los campos'),
        type: ToastificationType.error,
        autoCloseDuration: Duration(seconds: 3),
      );
    }
  }




  void changeEmail(String value) {
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


}