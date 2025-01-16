import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbox/src/presentation/pages/auth/lostPasword/widget/lost_password_content.dart';

import 'lost_password_viewmodel.dart';

class LostPasswordPage extends StatelessWidget {
  const LostPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {

    LostPasswordViewModel vm = Provider.of<LostPasswordViewModel>(context);

    return Scaffold(
      body: Container(child: LostPasswordContent(vm),
      ),
    );
  }
}
