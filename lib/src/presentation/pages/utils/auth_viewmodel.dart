import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  String? _token;
  int? _userId;

  /// Determina si el usuario está logueado.
  /// (Podrías chequear solo el token o también `userId`).
  bool get isLoggedIn => _token != null && _userId != null;

  /// Getter para usar _userId si lo necesitas en la app.
  int? get userId => _userId;

  /// Método para almacenar token y userId en memoria y en SharedPreferences
  Future<void> login(String token, int userId) async {
    _token = token;
    _userId = userId;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setInt('userId', userId);

    notifyListeners();
  }

  /// Método para cerrar sesión: borra token y userId de memoria y de SharedPreferences
  Future<void> logout() async {
    _token = null;
    _userId = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userId');

    notifyListeners();
  }

  /// Método para cargar token y userId al iniciar la app
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _userId = prefs.getInt('userId');
    notifyListeners();
  }
}
