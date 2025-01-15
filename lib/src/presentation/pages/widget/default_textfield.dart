import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {

  final String label;
  final IconData icon;
  String error;
  Function(String text) onChanged;
  bool obscureText;

  DefaultTextField({
    required this.label,
    required this.icon,
    this.error = '',
    required this.onChanged,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) { onChanged(value); },
      decoration: InputDecoration(
        label: Text(
          label,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        errorText: error,
        suffixIcon: Icon(
          icon,
          color: Colors.black,
        ),
      ),
      style: TextStyle(
        color: Colors.black,
      ),
      obscureText: obscureText,
    );
  }
}
