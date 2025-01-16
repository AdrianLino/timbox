import 'package:flutter/material.dart';

class EstadoDropdown extends StatelessWidget {
  final String? error;
  final Function(int estadoId) onChanged;

  EstadoDropdown({Key? key, this.error, required this.onChanged}) : super(key: key);

  final List<Map<String, dynamic>> estados = [
    {'id': 1, 'nombre': 'Aguascalientes'},
    {'id': 2, 'nombre': 'Baja California'},
    {'id': 3, 'nombre': 'Baja California Sur'},
    {'id': 4, 'nombre': 'Campeche'},
    {'id': 5, 'nombre': 'Chiapas'},
    {'id': 6, 'nombre': 'Chihuahua'},
    {'id': 7, 'nombre': 'Ciudad de México'},
    {'id': 8, 'nombre': 'Coahuila'},
    {'id': 9, 'nombre': 'Colima'},
    {'id': 10, 'nombre': 'Durango'},
    {'id': 11, 'nombre': 'Estado de México'},
    {'id': 12, 'nombre': 'Guanajuato'},
    {'id': 13, 'nombre': 'Guerrero'},
    {'id': 14, 'nombre': 'Hidalgo'},
    {'id': 15, 'nombre': 'Jalisco'},
    {'id': 16, 'nombre': 'Michoacán'},
    {'id': 17, 'nombre': 'Morelos'},
    {'id': 18, 'nombre': 'Nayarit'},
    {'id': 19, 'nombre': 'Nuevo León'},
    {'id': 20, 'nombre': 'Oaxaca'},
    {'id': 21, 'nombre': 'Puebla'},
    {'id': 22, 'nombre': 'Querétaro'},
    {'id': 23, 'nombre': 'Quintana Roo'},
    {'id': 24, 'nombre': 'San Luis Potosí'},
    {'id': 25, 'nombre': 'Sinaloa'},
    {'id': 26, 'nombre': 'Sonora'},
    {'id': 27, 'nombre': 'Tabasco'},
    {'id': 28, 'nombre': 'Tamaulipas'},
    {'id': 29, 'nombre': 'Tlaxcala'},
    {'id': 30, 'nombre': 'Veracruz'},
    {'id': 31, 'nombre': 'Yucatán'},
    {'id': 32, 'nombre': 'Zacatecas'},
  ];

  @override
  Widget build(BuildContext context) {
    int? selectedEstado;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<int>(
          decoration: InputDecoration(
            labelText: 'Estado',
            labelStyle: const TextStyle(color: Colors.black),
            errorText: error,
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.map_outlined, color: Colors.black),
          ),
          items: estados.map((estado) {
            return DropdownMenuItem<int>(
              value: estado['id'],
              child: Text(estado['nombre']),
            );
          }).toList(),
          onChanged: (value) {
            selectedEstado = value;
            if (value != null) {
              onChanged(value);
            }
          },
        ),
      ],
    );
  }
}
