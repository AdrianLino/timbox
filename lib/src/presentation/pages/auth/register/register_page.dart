import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart'; // Importa Toastification
import 'package:timbox/src/presentation/pages/auth/register/register_viewmodel.dart';
import 'package:timbox/src/presentation/pages/auth/register/widgets/register_content.dart';

import '../../../../domain/utils/resource.dart';
import '../../utils/base_color.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterViewModel vm = Provider.of<RegisterViewModel>(context); //Se debe instanciar el viewmodel

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

                // Usar Toastification
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  toastification.show(
                    context: context,
                    title: Text("Error"),
                    description: Text('${data.error.toString()}'),
                    type: ToastificationType.error,
                    autoCloseDuration: Duration(seconds: 3),
                    animationDuration: Duration(milliseconds: 300),
                  );
                });
              }
              if (response is Success) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  toastification.show(
                    context: context,
                    title: Text("Buen trabajo"),
                    description: Text('Tu registro fue exitoso'),
                    type: ToastificationType.success,
                    autoCloseDuration: Duration(seconds: 3),
                    animationDuration: Duration(milliseconds: 300),
                  );
                });

              }
              return Container();
            },
          ),
          RegisterContent(vm)
        ],
      ),
    );
  }
}
