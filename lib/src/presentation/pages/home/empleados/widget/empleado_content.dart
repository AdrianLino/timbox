import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbox/src/presentation/pages/home/colaborador/widget/colaborador_content.dart';
import 'package:toastification/toastification.dart';

import '../../../../../domain/models/colaborador_data.dart';
import '../../../../../domain/utils/resource.dart';
import '../../layouts/layout.dart';
import '../empleados_page.dart';
import '../empleados_viewmodel.dart';
import 'empleado_editar.dart'; // Importa Toastification

class EmpleadoContent extends StatelessWidget {

  EmpleadosViewmodel vm;
  ColaboradorData colaboradorData;

  EmpleadoContent(this.vm, this.colaboradorData);



  @override
  Widget build(BuildContext context) {
    EmpleadosViewmodel vm = Provider.of<EmpleadosViewmodel>(context); //Se debe instanciar el viewmodel

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
                      MaterialPageRoute(builder: (context) => EmpleadosPage()),
                    );
                  });






                }
                return Container();
              },
            ),
            EmpleadoEditar(vm , colaboradorData),
          ],
        ),
      ),
    );
  }
}
