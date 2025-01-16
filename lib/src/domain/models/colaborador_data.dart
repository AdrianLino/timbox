
class ColaboradorData {
  final int id;
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
  final int id_estado;

  ColaboradorData({
    this.id = 0,
    this.idPersona = 0,
    this.nombre = '',
    this.correo = '',
    this.rfc = '',
    this.domicilioFiscal = '',
    this.curp = '',
    this.nSeguridadSocial = '',
    DateTime? fechaInicio,  // <-- Aceptamos null o un DateTime
    this.tipoContrato = '',
    this.departamento = '',
    this.puesto = '',
    this.salarioDiario = '',
    this.salario = '',
    this.claveEntidad = '',
    this.id_estado = 0,
  }) : fechaInicio = fechaInicio ?? DateTime.now();



  factory ColaboradorData.fromJson(Map<String, dynamic> json) {
    return ColaboradorData(
      id: json['id'] ?? 0,
      idPersona: json['id_persona'] ?? 0,
      nombre: json['nombre'] ?? '',
      correo: json['correo'] ?? '',
      rfc: json['rfc'] ?? '',
      domicilioFiscal: json['domicilio_fiscal'] ?? '',
      curp: json['curp'] ?? '',
      nSeguridadSocial: json['n_seguridad_social'] ?? '',
      fechaInicio: (json['fecha_inicio'] == null)
          ? DateTime.now()
          : DateTime.parse(json['fecha_inicio']),
      tipoContrato: json['tipo_contrato'] ?? '',
      departamento: json['departamento'] ?? '',
      puesto: json['puesto'] ?? '',
      salarioDiario: json['salario_d'] ?? '',
      salario: json['salario'] ?? '',
      claveEntidad: json['clave_entidad'] ?? '',
      id_estado: json['id_estado'] ?? 0,
      // ^^^^^^^^^^^^^^^^^^^^^
      // Mapea la columna 'id_estado' de tu DB a la propiedad 'estado' de tu modelo
    );
  }

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
      'id_estado': id_estado,
      // ^^^^^^^^^^^^^^^^^
      // Aquí la propiedad 'estado' del modelo se enviará como 'id_estado' al backend
    };
  }
}
