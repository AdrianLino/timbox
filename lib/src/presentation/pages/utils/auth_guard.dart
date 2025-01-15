import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_viewmodel.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();

    if (!authViewModel.isLoggedIn) {
      Future.microtask(() {
        Navigator.pushReplacementNamed(context, 'login');
      });
      return const SizedBox.shrink(); // Retorna un widget vacío mientras redirige
    }

    return child;
  }
}
