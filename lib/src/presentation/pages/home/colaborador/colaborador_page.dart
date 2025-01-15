import 'package:flutter/material.dart';

import '../layouts/layout.dart';


class ColaboradorPage extends StatefulWidget {
  const ColaboradorPage({super.key});

  @override
  State<ColaboradorPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ColaboradorPage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        child: Center(
          child: Text('holaaa Colaborador'),
        )
    );
  }

}

