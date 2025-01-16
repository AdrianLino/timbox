
class ColaboradorData {
  final int idPersona;
  final String nombre;
  final String correo;
  final String rfc;
  final String domicilioFiscal;
  final String curp;
  final String nSeguridadSocial;
  final DateTime fechaInicio;
  final String tipoContrato;
  final String departamento;
  final String puesto;
  final String salarioDiario;
  final String salario;
  final String claveEntidad;
  final int estado;

  ColaboradorData({
    required this.idPersona,
    required this.nombre,
    required this.correo,
    required this.rfc,
    required this.domicilioFiscal,
    required this.curp,
    required this.nSeguridadSocial,
    required this.fechaInicio,
    required this.tipoContrato,
    required this.departamento,
    required this.puesto,
    required this.salarioDiario,
    required this.salario,
    required this.claveEntidad,
    required this.estado,
  });

  // Para convertir datos de MySQL a un objeto DetallePersonal
  factory ColaboradorData.fromJson(Map<String, dynamic> json) {
    return ColaboradorData(
      idPersona: json['id_persona'],
      nombre: json['nombre'],
      correo: json['correo'],
      rfc: json['rfc'],
      domicilioFiscal: json['domicilio_fiscal'],
      curp: json['curp'],
      nSeguridadSocial: json['n_seguridad_social'],
      fechaInicio: DateTime.parse(json['fecha_inicio']),
      tipoContrato: json['tipo_contrato'],
      departamento: json['departamento'],
      puesto: json['puesto'],
      salarioDiario: json['salario_d'],
      salario: json['salario'],
      claveEntidad: json['clave_entidad'],
      estado: json['estado'],
    );
  }

  // Para convertir un objeto DetallePersonal a JSON
  Map<String, dynamic> toJson() {
    return {
      'id_persona': idPersona,
      'nombre': nombre,
      'correo': correo,
      'rfc': rfc,
      'domicilio_fiscal': domicilioFiscal,
      'curp': curp,
      'n_seguridad_social': nSeguridadSocial,
      'fecha_inicio': fechaInicio.toIso8601String(),
      'tipo_contrato': tipoContrato,
      'departamento': departamento,
      'puesto': puesto,
      'salario_d': salarioDiario,
      'salario': salario,
      'clave_entidad': claveEntidad,
      'estado': estado,
    };
  }
}
