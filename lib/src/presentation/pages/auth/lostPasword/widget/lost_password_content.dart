import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:timbox/src/presentation/pages/auth/lostPasword/lost_password_viewmodel.dart';
import '../../../utils/base_color.dart';
import '../../../widget/default_button.dart';
import '../../../widget/default_textfield.dart';

class LostPasswordContent extends StatelessWidget {

  LostPasswordViewModel vm;

  LostPasswordContent(this.vm);


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

                      Text("Valida tu cuenta",
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
            margin: EdgeInsets.symmetric(horizontal: 120,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      DefaultTextField(label: 'Correo Electronico', icon: Icons.email_outlined,error: vm.state.email.error, onChanged: (value) {vm.changeEmail(value);}),
                      DefaultTextField(label: 'RFC', icon: Icons.account_box_outlined,error: vm.state.rfc.error, onChanged: (value) {vm.changerfc(value);}),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 40),
                          child:
                          DefaultButton(text: 'Validar',
                              onPressed: () {
                            vm.ConfirmCredentials(context);
                            //vm.register();
                          })
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
