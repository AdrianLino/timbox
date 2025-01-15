import 'package:flutter/material.dart';

import '../layouts/layout.dart';


class CargaArchivosPage extends StatefulWidget {
  const CargaArchivosPage({super.key});

  @override
  State<CargaArchivosPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CargaArchivosPage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        child: Center(
          child: Text('holaaa'),
        )
    );
  }

}

