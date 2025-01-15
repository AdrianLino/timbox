class PersonasData {

  final String nombre;
  final String correo;
  final String rfc;
  final String password;

  PersonasData({
    required this.nombre,
    required this.correo,
    required this.rfc,
    required this.password,
  });


  factory PersonasData.fromJson(Map<String, dynamic> json) {
    return PersonasData(
      nombre: json['nombre'],
      correo: json['correo'],
      rfc: json['rfc'],
      password: json['password'],
    );
  }

  // Para convertir un objeto Persona a JSON (por ejemplo, para enviar datos al servidor)
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'correo': correo,
      'rfc': rfc,
      'password': password,
    };
  }
}
