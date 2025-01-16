import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbox/src/presentation/pages/home/colaborador/widget/colaborador_content.dart';
import 'package:toastification/toastification.dart'; // Importa Toastification
import 'package:timbox/src/presentation/pages/auth/register/register_viewmodel.dart';
import 'package:timbox/src/presentation/pages/auth/register/widgets/register_content.dart';

import '../../../../domain/utils/resource.dart';
import '../../utils/auth_viewmodel.dart';
import '../../utils/base_color.dart';
import '../carga_archivos/carga_archivos_page.dart';
import '../layouts/layout.dart';
import 'colaborador_viewmodel.dart';

class ColaboradorPage extends StatelessWidget {
  const ColaboradorPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColaboradorViewModel vm = Provider.of<ColaboradorViewModel>(context); //Se debe instanciar el viewmodel

    return Scaffold(
      backgroundColor: Colors.white,
      body: Layout(
        child: Stack(
          children: [
            StreamBuilder(
              stream: vm.response,
              builder: (context, snapshot){
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
                  WidgetsBinding.instance.addPostFrameCallback((_) async{
                    toastification.show(
                      context: context,
                      title: Text("Exito"),
                      description: Text('Colaborador registrado correctamente'),
                      type: ToastificationType.success,
                      autoCloseDuration: Duration(seconds: 2),
                      animationDuration: Duration(milliseconds: 300),
                    );
                    await Future.delayed(Duration(seconds: 2));

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ColaboradorPage()),
                    );
                  });






                }
                return Container();
              },
            ),
            ColaboradorContent(vm)
          ],
        ),
      ),
    );
  }
}
