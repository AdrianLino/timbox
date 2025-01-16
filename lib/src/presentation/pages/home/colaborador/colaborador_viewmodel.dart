
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

import '../../../../domain/models/colaborador_data.dart';
import '../../../../domain/use_cases/colaborador/colaborador_usecases.dart';
import '../../../../domain/utils/resource.dart';
import '../../utils/validation_item.dart';
import 'colaborador_state.dart';

class ColaboradorViewModel extends ChangeNotifier {


  ColaboradorUseCases _colaboradorUseCases;

  ColaboradorViewModel(this._colaboradorUseCases);

  ColaboradorState _state = ColaboradorState();
  ColaboradorState  get state => _state;

  StreamController<Resource> _responsecontroller = StreamController<Resource>.broadcast();
  Stream<Resource> get response => _responsecontroller.stream;






  register(context) async{
    final prefs = await SharedPreferences.getInstance();;
    final savedUserId = prefs.getInt('userId');
    _state =await  _state.copyWith(
      idPersona: ValidationItem(value: savedUserId.toString(), error: ''),
    );
    if (_state.isValid()) {
      _responsecontroller.add(Loading()); //esperando la respuesta

      final data = await _colaboradorUseCases.registerColaborador.launch(
          colaboradorData:  _state.toUser()
      );
      _responsecontroller.add(data);
    } else {
      toastification.show(
        context: context,
        title: Text("Error"),
        description: Text('El formulario no esta completo'),
        type: ToastificationType.warning,
        autoCloseDuration: Duration(seconds: 2),
        animationDuration: Duration(milliseconds: 300),
      );
    }
  }




  void changeNombre(String value) {
    _responsecontroller.add(Init());

    // Validar longitud mínima (ej. >= 3 caracteres)
    if (value.trim().length < 3) {
      _state = _state.copyWith(
        nombre: ValidationItem(
          value: value,
          error: 'El nombre debe tener al menos 3 caracteres',
        ),
      );
    } else {
      _state = _state.copyWith(
        nombre: ValidationItem(value: value.trim(), error: ''),
      );
    }
    notifyListeners();
  }

// ============================
// 3) changeCorreo (similar a tu changeEmail)
// ============================
  void changeCorreo(String value) {
    _responsecontroller.add(Init());

    final bool emailFormatValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+\-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$",
    ).hasMatch(value);

    if (!emailFormatValid) {
      _state = _state.copyWith(
        correo: ValidationItem(
          value: value,
          error: 'No es un email válido',
        ),
      );
    } else if (value.length < 6) {
      _state = _state.copyWith(
        correo: ValidationItem(
          value: value,
          error: 'El email debe tener al menos 6 caracteres',
        ),
      );
    } else {
      _state = _state.copyWith(
        correo: ValidationItem(value: value, error: ''),
      );
    }

    notifyListeners();
  }

// ============================
// 4) changeRfc
// ============================
  void changeRfc(String value) {
    _responsecontroller.add(Init());

    // Por ejemplo, RFC con longitud 12 o 13
    if (value.trim().length < 12) {
      _state = _state.copyWith(
        rfc: ValidationItem(
          value: value,
          error: 'El RFC debe tener al menos 12 caracteres',
        ),
      );
    } else {
      _state = _state.copyWith(
        rfc: ValidationItem(value: value.trim(), error: ''),
      );
    }
    notifyListeners();
  }

// ============================
// 5) changeDomicilioFiscal
// ============================
  void changeDomicilioFiscal(String value) {
    _responsecontroller.add(Init());

    if (value.trim().length < 5) {
      _state = _state.copyWith(
        domicilioFiscal: ValidationItem(
          value: value,
          error: 'El domicilio debe tener al menos 5 caracteres',
        ),
      );
    } else {
      _state = _state.copyWith(
        domicilioFiscal: ValidationItem(value: value.trim(), error: ''),
      );
    }
    notifyListeners();
  }

// ============================
// 6) changeCurp
// ============================
  void changeCurp(String value) {
    _responsecontroller.add(Init());

    // CURP suele ser de 18 caracteres
    if (value.trim().length != 18) {
      _state = _state.copyWith(
        curp: ValidationItem(
          value: value,
          error: 'La CURP debe tener exactamente 18 caracteres',
        ),
      );
    } else {
      _state = _state.copyWith(
        curp: ValidationItem(value: value.trim(), error: ''),
      );
    }
    notifyListeners();
  }

// ============================
// 7) changeNSeguridadSocial
// ============================
  void changeNSeguridadSocial(String value) {
    _responsecontroller.add(Init());

    // Ejemplo: mínimo 10 caracteres
    if (value.trim().length < 10) {
      _state = _state.copyWith(
        nSeguridadSocial: ValidationItem(
          value: value,
          error: 'El número de Seguro Social debe tener al menos 10 caracteres',
        ),
      );
    } else {
      _state = _state.copyWith(
        nSeguridadSocial: ValidationItem(value: value.trim(), error: ''),
      );
    }
    notifyListeners();
  }

// ============================
// 8) changeFInicioLaboral
// ============================
  void changeFInicioLaboral(String value) {
    _responsecontroller.add(Init());

    // El formato esperado es 'YYYY-MM-DD'
    try {
      // Intentamos parsear la cadena a DateTime
      final date = DateTime.parse(value.trim());

      // Si la conversión tuvo éxito, actualizamos el estado sin error
      _state = _state.copyWith(
        fInicioLaboral: ValidationItem(value: value.trim(), error: ''),
      );
    } catch (e) {
      // Si ocurre un error, significa que no es un formato de fecha válido
      _state = _state.copyWith(
        fInicioLaboral: ValidationItem(
          value: value.trim(),
          error: 'Fecha inválida. Use el formato YYYY-MM-DD',
        ),
      );
    }

    notifyListeners();
  }


// ============================
// 9) changeTContrato
// ============================
  void changeTContrato(String value) {
    _responsecontroller.add(Init());

    // Validación simple (ej: mínimo 3 caracteres)
    if (value.trim().length < 3) {
      _state = _state.copyWith(
        tContrato: ValidationItem(
          value: value,
          error: 'El tipo de contrato debe tener al menos 3 caracteres',
        ),
      );
    } else {
      _state = _state.copyWith(
        tContrato: ValidationItem(value: value.trim(), error: ''),
      );
    }
    notifyListeners();
  }

// ============================
// 10) changeDepartamento
// ============================
  void changeDepartamento(String value) {
    _responsecontroller.add(Init());

    if (value.trim().length < 3) {
      _state = _state.copyWith(
        departamento: ValidationItem(
          value: value,
          error: 'El departamento debe tener al menos 3 caracteres',
        ),
      );
    } else {
      _state = _state.copyWith(
        departamento: ValidationItem(value: value.trim(), error: ''),
      );
    }
    notifyListeners();
  }

// ============================
// 11) changePuesto
// ============================
  void changePuesto(String value) {
    _responsecontroller.add(Init());

    if (value.trim().length < 3) {
      _state = _state.copyWith(
        puesto: ValidationItem(
          value: value,
          error: 'El puesto debe tener al menos 3 caracteres',
        ),
      );
    } else {
      _state = _state.copyWith(
        puesto: ValidationItem(value: value.trim(), error: ''),
      );
    }
    notifyListeners();
  }

// ============================
// 12) changeSalarioD
// ============================
  void changeSalarioD(String value) {
    _responsecontroller.add(Init());

    // Salario diario, validar que sea numérico o decimal
    final doubleVal = double.tryParse(value.replaceAll(',', '.'));
    if (doubleVal == null || doubleVal <= 0) {
      _state = _state.copyWith(
        salarioD: ValidationItem(
          value: value,
          error: 'Salario diario inválido. Debe ser un número mayor a 0.',
        ),
      );
    } else {
      _state = _state.copyWith(
        salarioD: ValidationItem(value: value, error: ''),
      );
    }
    notifyListeners();
  }

// ============================
// 13) changeSalario
// ============================
  void changeSalario(String value) {
    _responsecontroller.add(Init());

    final doubleVal = double.tryParse(value.replaceAll(',', '.'));
    if (doubleVal == null || doubleVal <= 0) {
      _state = _state.copyWith(
        salario: ValidationItem(
          value: value,
          error: 'Salario inválido. Debe ser un número mayor a 0.',
        ),
      );
    } else {
      _state = _state.copyWith(
        salario: ValidationItem(value: value, error: ''),
      );
    }
    notifyListeners();
  }

// ============================
// 14) changeClaveEntidad
// ============================
  void changeClaveEntidad(String value) {
    _responsecontroller.add(Init());

    if (value.trim().length < 2) {
      _state = _state.copyWith(
        claveEntidad: ValidationItem(
          value: value,
          error: 'La clave de la entidad debe tener al menos 2 caracteres',
        ),
      );
    } else {
      _state = _state.copyWith(
        claveEntidad: ValidationItem(value: value.trim(), error: ''),
      );
    }
    notifyListeners();
  }

// ============================
// 15) changeEstado
// ============================
  void changeEstado(int value) {
    _responsecontroller.add(Init());
      _state = _state.copyWith(
        estado: value,
      );
    notifyListeners();
  }



  void resetFields() {
    _responsecontroller.add(Init());

    _state = ColaboradorState(
      idPersona: ValidationItem(value: '', error: ''),
      nombre: ValidationItem(value: '', error: ''),
      correo: ValidationItem(value: '', error: ''),
      rfc: ValidationItem(value: '', error: ''),
      domicilioFiscal: ValidationItem(value: '', error: ''),
      curp: ValidationItem(value: '', error: ''),
      nSeguridadSocial: ValidationItem(value: '', error: ''),
      fInicioLaboral: ValidationItem(value: '', error: ''),
      tContrato: ValidationItem(value: '', error: ''),
      departamento: ValidationItem(value: '', error: ''),
      puesto: ValidationItem(value: '', error: ''),
      salarioD: ValidationItem(value: '', error: ''),
      salario: ValidationItem(value: '', error: ''),
      claveEntidad: ValidationItem(value: '', error: ''),
      estado: 0, // O el valor predeterminado si no puede ser null
    );

    notifyListeners();
  }

}