import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FechaPickerField extends StatefulWidget {
  final String etiqueta;
  final IconData icono;
  final String error;
  final String valorInicial; // Si tu ViewModel ya tiene una fecha inicial
  final Function(String) onFechaSeleccionada;

  const FechaPickerField({
    Key? key,
    required this.etiqueta,
    required this.icono,
    this.error = '',
    this.valorInicial = '',
    required this.onFechaSeleccionada,
  }) : super(key: key);

  @override
  _CampoFechaPickerState createState() => _CampoFechaPickerState();
}

class _CampoFechaPickerState extends State<FechaPickerField> {
  late TextEditingController _controlador;
  DateTime? _fechaElegida;

  @override
  void initState() {
    super.initState();
    _controlador = TextEditingController(text: widget.valorInicial);
  }

  @override
  void didUpdateWidget(FechaPickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si el valor inicial cambia externamente, actualizamos el campo
    if (widget.valorInicial != oldWidget.valorInicial) {
      _controlador.text = widget.valorInicial;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: _controlador,
      onTap: _mostrarCalendario,
      decoration: InputDecoration(
        // Estilo de la etiqueta (label)
        label: Text(
          widget.etiqueta,
          style: const TextStyle(color: Colors.black),
        ),
        labelStyle: const TextStyle(color: Colors.black),
        // Mensaje de error
        errorText: widget.error.isNotEmpty ? widget.error : null,
        // Ícono al final (suffixIcon) para asemejar al DefaultTextField
        suffixIcon: Icon(
          widget.icono,
          color: Colors.black,
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }

  Future<void> _mostrarCalendario() async {
    final hoy = DateTime.now();
    final fechaInicial = _fechaElegida ?? hoy;

    final seleccion = await showDatePicker(
      context: context,
      initialDate: fechaInicial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (seleccion != null) {
      _fechaElegida = seleccion;
      // Formato YYYY-MM-DD
      final formato = DateFormat('yyyy-MM-dd');
      final fechaFormateada = formato.format(seleccion);

      // Actualizamos el texto del TextField
      setState(() {
        _controlador.text = fechaFormateada;
      });

      // Notificamos al callback (por ejemplo, tu ViewModel)
      widget.onFechaSeleccionada(fechaFormateada);
    }
  }
}
