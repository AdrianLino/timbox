import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../../../utils/base_color.dart';
import '../../../widget/default_button.dart';
import '../../../widget/default_textfield.dart';
import '../login_viewmodel.dart';

class LoginContent extends StatelessWidget {

      LoginViewModel vm;

      LoginContent(this.vm);
    
      @override
      Widget build(BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.32,
                  color: BASE_COLOR,
                  child: Row(
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
                ),
              ),
              _buildTextFieldDescription(),
              Container(
                margin: EdgeInsets.only(left: 15, bottom: 80),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: DefaultTextField(
                  onChanged: (value) { vm.ChangeEmail(value); },
                  error: vm.state.email.error,
                  label: "Correo Electrónico",
                  icon: Icons.email_outlined,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child:DefaultTextField(
                  onChanged: (value) { vm.ChangePassword(value); },
                  error: vm.state.password.error,
                  label: "Contraseña",
                  icon: Icons.lock_outline,
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                child:DefaultButton(
                  text: "Iniciar Sesión",
                  onPressed: (){
                    vm.login();
                  },
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 40),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, 'register');
                    },
                    child: Text(
                      "¿No tienes cuenta?",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  )
              ),
            ],
          ),
        );
      }

      Widget _buildTextFieldDescription(){
        return Container(
          margin: EdgeInsets.only(left: 15, top: 15),
          child: Text(
            "Continua con",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        );
      }
    }
    