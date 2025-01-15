import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:provider/provider.dart';
import 'package:timbox/src/presentation/pages/auth/register/register_viewmodel.dart';

import '../../../utils/base_color.dart';
import '../../../widget/default_button.dart';
import '../../../widget/default_textfield.dart';

class RegisterContent extends StatelessWidget {

  RegisterViewModel vm;
  RegisterContent(this.vm);


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.30,
              color: BASE_COLOR,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 20, top: 40),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 35
                        ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/img/gamepad.png',
                        width: 150,
                        height: 100,
                      ),
                      Text("Games Firebase",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
                Text(
                  'Continua con tu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'Registro',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),

                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      DefaultTextField(label: 'Nombre de usuario', icon: Icons.person_outline,error:vm.state.username.error, onChanged: (value) { vm.changeUsername(value);}),
                      DefaultTextField(label: 'Correo Electronico', icon: Icons.email_outlined,error: vm.state.email.error, onChanged: (value) {vm.changeEmail(value);}),
                      DefaultTextField(label: 'RFC', icon: Icons.account_box_outlined,error: vm.state.rfc.error, onChanged: (value) {vm.changerfc(value);}),
                      DefaultTextField(label: 'Contraeña', icon: Icons.lock_outlined,obscureText: true,error: vm.state.password.error, onChanged: (value) {vm.changePassword(value);}),
                      DefaultTextField(label: 'Confirmar Contraseña', icon: Icons.lock_outline_rounded,obscureText: true,error: vm.state.confirmPassword.error, onChanged: (value) {vm.changeConfirmPassword(value);}),
                      Container(
                      margin: EdgeInsets.symmetric(vertical: 40),
                          child:
                            DefaultButton(text: 'Registrarse', onPressed: () {vm.register();})
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
