class ArchivosData {
  final int id;
  final int idPersona;
  final String nombre;
  final String extension;
  final String link;
  final String fechaCreacion;

  ArchivosData({
    required this.id,
    required this.idPersona,
    required this.nombre,
    required this.extension,
    required this.link,
    required this.fechaCreacion,
  });

  // Para convertir datos de MySQL a un objeto Archivo
  factory ArchivosData.fromJson(Map<String, dynamic> json) {
    return ArchivosData(
      id: json['id'],
      idPersona: json['id_persona'],
      nombre: json['nombre'],
      extension: json['extension'],
      link: json['link'],
      fechaCreacion: json['fecha_creacion'],
    );
  }

  // Para convertir un objeto Archivo a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_persona': idPersona,
      'nombre': nombre,
      'extension': extension,
      'link': link,
      'fecha_creacion': fechaCreacion,
    };
  }
}
