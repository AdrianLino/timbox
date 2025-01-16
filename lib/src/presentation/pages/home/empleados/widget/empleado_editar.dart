import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:provider/provider.dart';
import 'package:timbox/src/presentation/pages/auth/register/register_viewmodel.dart';

import '../../../../../domain/models/colaborador_data.dart';
import '../../../utils/base_color.dart';
import '../../../widget/default_button.dart';
import '../../../widget/default_textfield.dart';
import '../../colaborador/widget/EstadoDropdown.dart';
import '../../colaborador/widget/fecha_picker_field.dart';
import '../empleados_viewmodel.dart';


class EmpleadoEditar extends StatelessWidget {

  EmpleadosViewmodel vm;
  ColaboradorData colaboradorData;


  EmpleadoEditar(this.vm, this.colaboradorData){
    vm.valores(colaboradorData);
  }


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
                        initialValue: colaboradorData.nombre,
                        onChanged: (value) => vm.changeNombre(value),
                      ),
                      DefaultTextField(
                        label: 'Correo Electrónico',
                        icon: Icons.email_outlined,
                        error: vm.state.correo.error,
                        initialValue: colaboradorData.correo,
                        onChanged: (value) => vm.changeCorreo(value),
                      ),
                      DefaultTextField(
                        label: 'RFC',
                        icon: Icons.assignment_ind_outlined,
                        error: vm.state.rfc.error,
                        initialValue: colaboradorData.rfc,
                        onChanged: (value) => vm.changeRfc(value),
                      ),
                      DefaultTextField(
                        label: 'Domicilio Fiscal',
                        icon: Icons.home_outlined,
                        error: vm.state.domicilioFiscal.error,
                        initialValue: colaboradorData.domicilioFiscal,
                        onChanged: (value) => vm.changeDomicilioFiscal(value),
                      ),
                      DefaultTextField(
                        label: 'CURP',
                        icon: Icons.contact_mail_outlined,
                        error: vm.state.curp.error,
                        initialValue: colaboradorData.curp,
                        onChanged: (value) => vm.changeCurp(value),
                      ),
                      DefaultTextField(
                        label: 'N° Seguro Social',
                        icon: Icons.badge_outlined,
                        error: vm.state.nSeguridadSocial.error,
                        initialValue: colaboradorData.nSeguridadSocial,
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
                        initialValue: colaboradorData.tipoContrato,
                        onChanged: (value) => vm.changeTContrato(value),
                      ),
                      DefaultTextField(
                        label: 'Departamento',
                        icon: Icons.apartment_outlined,
                        error: vm.state.departamento.error,
                        initialValue: colaboradorData.departamento,
                        onChanged: (value) => vm.changeDepartamento(value),
                      ),
                      DefaultTextField(
                        label: 'Puesto',
                        icon: Icons.work_outline,
                        error: vm.state.puesto.error,
                        initialValue: colaboradorData.puesto,
                        onChanged: (value) => vm.changePuesto(value),
                      ),
                      DefaultTextField(
                        label: 'Salario Diario',
                        icon: Icons.attach_money_outlined,
                        error: vm.state.salarioD.error,
                        initialValue: colaboradorData.salarioDiario,
                        onChanged: (value) => vm.changeSalarioD(value),
                      ),
                      DefaultTextField(
                        label: 'Salario',
                        icon: Icons.money_outlined,
                        error: vm.state.salario.error,
                        initialValue: colaboradorData.salario,
                        onChanged: (value) => vm.changeSalario(value),
                      ),
                      DefaultTextField(
                        label: 'Clave Entidad',
                        icon: Icons.location_city_outlined,
                        error: vm.state.claveEntidad.error,
                        initialValue: colaboradorData.claveEntidad,
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
                          DefaultButton(text: 'Actualizar Colaborador', onPressed: () {vm.actualizar(context,colaboradorData );})
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
