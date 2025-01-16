import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timbox/src/presentation/pages/home/empleados/widget/empleado_state.dart';
import 'package:toastification/toastification.dart';

import '../../../../domain/models/colaborador_data.dart';
import '../../../../domain/use_cases/colaborador/colaborador_usecases.dart';
import '../../../../domain/utils/resource.dart';
import '../../utils/validation_item.dart';
import '../colaborador/colaborador_page.dart';
import 'empleados_page.dart';

class EmpleadosViewmodel extends ChangeNotifier {

  ColaboradorUseCases colaboradorUseCases;

  EmpleadosViewmodel(this.colaboradorUseCases);


  empleadoState _state = empleadoState();
  empleadoState  get state => _state;

  StreamController<Resource> _responsecontroller = StreamController<Resource>.broadcast();
  Stream<Resource> get response => _responsecontroller.stream;




  actualizar(context, ColaboradorData colaboradorData) async{
    final prefs = await SharedPreferences.getInstance();;
    final savedUserId = prefs.getInt('userId');
    _state =await  _state.copyWith(
      idPersona: ValidationItem(value: savedUserId.toString(), error: ''),
    );
    if (_state.isValid()) {
      _responsecontroller.add(Loading()); //esperando la respuesta

      final data = await colaboradorUseCases.updateColaborador.launch(
          colaboradorId: colaboradorData.id , colaborador: _state.toUser()
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



  void valores(ColaboradorData cd){
    _state = _state.copyWith(
      idPersona: ValidationItem(value: cd.idPersona.toString(), error: ''),
      nombre: ValidationItem(value: cd.nombre, error: ''),
      correo: ValidationItem(value: cd.correo, error: ''),
      rfc: ValidationItem(value: cd.rfc, error: ''),
      domicilioFiscal: ValidationItem(value: cd.domicilioFiscal, error: ''),
      curp: ValidationItem(value: cd.curp, error: ''),
      nSeguridadSocial: ValidationItem(value: cd.nSeguridadSocial, error: ''),
      fInicioLaboral: ValidationItem(value: cd.fechaInicio.toString(), error: ''),
      tContrato: ValidationItem(value: cd.tipoContrato, error: ''),
      departamento: ValidationItem(value: cd.departamento, error: ''),
      puesto: ValidationItem(value: cd.puesto, error: ''),
      salarioD: ValidationItem(value: cd.salarioDiario.toString(), error: ''),
      salario: ValidationItem(value: cd.salario.toString(), error: ''),
      claveEntidad: ValidationItem(value: cd.claveEntidad, error: ''),
      estado: cd.id_estado,
    );

  }





  Future<List<ColaboradorData>> obtenerArchivos() async {
    try {
      final prefs = await SharedPreferences.getInstance();;
      final savedUserId = prefs.getInt('userId')!;
      final archivos = await colaboradorUseCases.getColaborador.launch(idPersona: savedUserId);
      print("Archivos: $archivos");
      return archivos;
    } catch (e) {
      print("Error al obtener archivos: $e");
      rethrow;
    }
  }

  Future<void> deleteColaborador(int colaboradorId, context)async{
    try {
      final data = await colaboradorUseCases.deleteColaborador.launch(
          colaboradorId: colaboradorId
      );
      WidgetsBinding.instance.addPostFrameCallback((_) async{
        toastification.show(
          context: context,
          title: Text("¡Listo!"),
          description: Text('Tu archivo a sido borrado con éxito'),
          type: ToastificationType.success,
          autoCloseDuration: Duration(seconds: 2),
          animationDuration: Duration(milliseconds: 300),
        );
        await Future.delayed(Duration(seconds: 2));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EmpleadosPage()),
        );
      });
    } catch (e) {
      print("Error al eliminar colaborador: $e");
      rethrow;
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


}
