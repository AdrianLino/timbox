import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbox/src/presentation/pages/auth/login/login_viewmodel.dart';
import 'package:timbox/src/presentation/pages/auth/login/widgets/login_content.dart';
import 'package:toastification/toastification.dart';

import '../../../../domain/utils/resource.dart';
import '../../utils/auth_viewmodel.dart';
import '../../utils/base_color.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    LoginViewModel vm = Provider.of<LoginViewModel>(context);

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: Stack(
        children: [
          StreamBuilder(
            stream: vm.response,
            builder: (context, snapshot) {
              final response = snapshot.data;

              if (response is Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (response is Error) {
                final data = response as Error;

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    toastification.show(
                      context: context,
                      title: Text("Error"),
                      description: Text('${data.error.toString()}'),
                      type: ToastificationType.error,
                      autoCloseDuration: Duration(seconds: 3),
                      animationDuration: Duration(milliseconds: 300),
                    );
                  }
                });
              }

              if (response is Success) {
                final token = response.data["token"];
                context.read<AuthViewModel>().login(token);

                // Navegación diferida con validación de montaje
                Future.microtask(() {
                  if (mounted) {
                    Navigator.pushReplacementNamed(context, 'prueba');
                  }
                });
              }

              return Container();
            },
          ),
          LoginContent(vm),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Aquí puedes cancelar cualquier stream o animación si fuera necesario
    super.dispose();
  }
}
