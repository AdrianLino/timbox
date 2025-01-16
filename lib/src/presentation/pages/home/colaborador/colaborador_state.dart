


import '../../../../domain/models/colaborador_data.dart';
import '../../../../domain/models/personas_data.dart';
import '../../utils/validation_item.dart';

class ColaboradorState {
  ValidationItem idPersona;
  ValidationItem nombre;
  ValidationItem correo;
  ValidationItem rfc;
  ValidationItem domicilioFiscal;
  ValidationItem curp;
  ValidationItem nSeguridadSocial;
  ValidationItem fInicioLaboral;
  ValidationItem tContrato;
  ValidationItem departamento;
  ValidationItem puesto;
  ValidationItem salarioD;
  ValidationItem salario;
  ValidationItem claveEntidad;
  int estado;
  ColaboradorState({
    this.idPersona = const ValidationItem(),
    this.nombre = const ValidationItem(),
    this.correo = const ValidationItem(),
    this.rfc = const ValidationItem(),
    this.domicilioFiscal = const ValidationItem(),
    this.curp = const ValidationItem(),
    this.nSeguridadSocial = const ValidationItem(),
    this.fInicioLaboral = const ValidationItem(),
    this.tContrato = const ValidationItem(),
    this.departamento = const ValidationItem(),
    this.puesto = const ValidationItem(),
    this.salarioD = const ValidationItem(),
    this.salario = const ValidationItem(),
    this.claveEntidad = const ValidationItem(),
    this.estado = 0,
  });

  toUser() => ColaboradorData(
    idPersona: int.parse(this.idPersona.value),
    nombre: this.nombre.value,
    correo: this.correo.value,
    rfc: this.rfc.value,
    domicilioFiscal: this.domicilioFiscal.value,
    curp: this.curp.value,
    nSeguridadSocial: this.nSeguridadSocial.value,
    fechaInicio: DateTime.parse(this.fInicioLaboral.value),
    tipoContrato: this.tContrato.value,
    departamento: this.departamento.value,
    puesto: this.puesto.value,
    salarioDiario: this.salarioD.value,
    salario: this.salario.value,
    claveEntidad: this.claveEntidad.value,
    estado: this.estado,
  );


  bool isValid() {
    if (idPersona.value.isNotEmpty &&
        idPersona.error.isEmpty &&
        nombre.value.isNotEmpty &&
        nombre.error.isEmpty &&
        correo.value.isNotEmpty &&
        correo.error.isEmpty &&
        rfc.value.isNotEmpty &&
        rfc.error.isEmpty &&
        domicilioFiscal.value.isNotEmpty &&
        domicilioFiscal.error.isEmpty &&
        curp.value.isNotEmpty &&
        curp.error.isEmpty &&
        nSeguridadSocial.value.isNotEmpty &&
        nSeguridadSocial.error.isEmpty &&
        fInicioLaboral.value.isNotEmpty &&
        fInicioLaboral.error.isEmpty &&
        tContrato.value.isNotEmpty &&
        tContrato.error.isEmpty &&
        departamento.value.isNotEmpty &&
        departamento.error.isEmpty &&
        puesto.value.isNotEmpty &&
        puesto.error.isEmpty &&
        salarioD.value.isNotEmpty &&
        salarioD.error.isEmpty &&
        salario.value.isNotEmpty &&
        salario.error.isEmpty &&
        claveEntidad.value.isNotEmpty &&
        claveEntidad.error.isEmpty  &&
        estado != 0

    ) {
      return true;
    } else {
      return false;
    }
  }

  ColaboradorState copyWith({
    ValidationItem? idPersona,
    ValidationItem? nombre,
    ValidationItem? correo,
    ValidationItem? rfc,
    ValidationItem? domicilioFiscal,
    ValidationItem? curp,
    ValidationItem? nSeguridadSocial,
    ValidationItem? fInicioLaboral,
    ValidationItem? tContrato,
    ValidationItem? departamento,
    ValidationItem? puesto,
    ValidationItem? salarioD,
    ValidationItem? salario,
    ValidationItem? claveEntidad,
    int? estado,
  }) =>
      ColaboradorState(
        idPersona: idPersona ?? this.idPersona,
        nombre: nombre ?? this.nombre,
        correo: correo ?? this.correo,
        rfc: rfc ?? this.rfc,
        domicilioFiscal: domicilioFiscal ?? this.domicilioFiscal,
        curp: curp ?? this.curp,
        nSeguridadSocial: nSeguridadSocial ?? this.nSeguridadSocial,
        fInicioLaboral: fInicioLaboral ?? this.fInicioLaboral,
        tContrato: tContrato ?? this.tContrato,
        departamento: departamento ?? this.departamento,
        puesto: puesto ?? this.puesto,
        salarioD: salarioD ?? this.salarioD,
        salario: salario ?? this.salario,
        claveEntidad: claveEntidad ?? this.claveEntidad,
        estado: estado ?? this.estado,
      );



}