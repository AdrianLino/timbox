import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:provider/provider.dart';
import 'package:timbox/src/presentation/pages/auth/register/register_viewmodel.dart';

import '../../../utils/base_color.dart';
import '../../../widget/default_button.dart';
import '../../../widget/default_textfield.dart';
import '../colaborador_viewmodel.dart';
import 'EstadoDropdown.dart';
import 'fecha_picker_field.dart';

class ColaboradorContent extends StatelessWidget {

  ColaboradorViewModel vm;
  ColaboradorContent(this.vm);


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: 100,
              color: BASE_COLOR,
              child: Center(
                child: Text(
                  'Registro de Colaborador',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 120,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      DefaultTextField(
                        label: 'Nombre',
                        icon: Icons.person_outline,
                        error: vm.state.nombre.error,
                        onChanged: (value) => vm.changeNombre(value),
                      ),
                      DefaultTextField(
                        label: 'Correo Electrónico',
                        icon: Icons.email_outlined,
                        error: vm.state.correo.error,
                        onChanged: (value) => vm.changeCorreo(value),
                      ),
                      DefaultTextField(
                        label: 'RFC',
                        icon: Icons.assignment_ind_outlined,
                        error: vm.state.rfc.error,
                        onChanged: (value) => vm.changeRfc(value),
                      ),
                      DefaultTextField(
                        label: 'Domicilio Fiscal',
                        icon: Icons.home_outlined,
                        error: vm.state.domicilioFiscal.error,
                        onChanged: (value) => vm.changeDomicilioFiscal(value),
                      ),
                      DefaultTextField(
                        label: 'CURP',
                        icon: Icons.contact_mail_outlined,
                        error: vm.state.curp.error,
                        onChanged: (value) => vm.changeCurp(value),
                      ),
                      DefaultTextField(
                        label: 'N° Seguro Social',
                        icon: Icons.badge_outlined,
                        error: vm.state.nSeguridadSocial.error,
                        onChanged: (value) => vm.changeNSeguridadSocial(value),
                      ),
                      FechaPickerField(
                        etiqueta: 'Fecha de Inicio Laboral',
                        icono: Icons.date_range_outlined,
                        error: vm.state.fInicioLaboral.error,
                        valorInicial: vm.state.fInicioLaboral.value,
                        onFechaSeleccionada: (fecha) {
                          vm.changeFInicioLaboral(fecha);
                        },
                      ),

                      DefaultTextField(
                        label: 'Tipo de Contrato',
                        icon: Icons.assignment_outlined,
                        error: vm.state.tContrato.error,
                        onChanged: (value) => vm.changeTContrato(value),
                      ),
                      DefaultTextField(
                        label: 'Departamento',
                        icon: Icons.apartment_outlined,
                        error: vm.state.departamento.error,
                        onChanged: (value) => vm.changeDepartamento(value),
                      ),
                      DefaultTextField(
                        label: 'Puesto',
                        icon: Icons.work_outline,
                        error: vm.state.puesto.error,
                        onChanged: (value) => vm.changePuesto(value),
                      ),
                      DefaultTextField(
                        label: 'Salario Diario',
                        icon: Icons.attach_money_outlined,
                        error: vm.state.salarioD.error,
                        onChanged: (value) => vm.changeSalarioD(value),
                      ),
                      DefaultTextField(
                        label: 'Salario',
                        icon: Icons.money_outlined,
                        error: vm.state.salario.error,
                        onChanged: (value) => vm.changeSalario(value),
                      ),
                      DefaultTextField(
                        label: 'Clave Entidad',
                        icon: Icons.location_city_outlined,
                        error: vm.state.claveEntidad.error,
                        onChanged: (value) => vm.changeClaveEntidad(value),
                      ),
                      EstadoDropdown(
                        error: null, // Puedes pasar un mensaje de error si lo necesitas
                        onChanged: (estadoId) {
                          vm.changeEstado(estadoId);
                          print('Estado seleccionado: $estadoId');
                        },
                      ),

                      Container(
                          margin: EdgeInsets.symmetric(vertical: 40),
                          child:
                          DefaultButton(text: 'Registrar Colaborador', onPressed: () {vm.register(context);})
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
