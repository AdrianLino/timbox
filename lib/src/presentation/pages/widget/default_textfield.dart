import 'package:flutter/material.dart';

class DefaultTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final String error;
  final Function(String text) onChanged;
  final bool obscureText;
  final String? initialValue; // Nuevo parámetro opcional para el valor inicial

  DefaultTextField({
    required this.label,
    required this.icon,
    this.error = '',
    required this.onChanged,
    this.obscureText = false,
    this.initialValue,
  });

  @override
  _DefaultTextFieldState createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Inicializar el controlador con el valor inicial si se proporciona
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller, // Asignar el controlador al TextField
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        label: Text(
          widget.label,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        errorText: widget.error.isEmpty ? null : widget.error,
        suffixIcon: Icon(
          widget.icon,
          color: Colors.black,
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
      ),
      obscureText: widget.obscureText,
    );
  }
}
