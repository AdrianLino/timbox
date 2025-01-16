import 'package:flutter/material.dart';
import 'package:timbox/src/presentation/pages/home/layouts/layout.dart';

class ServiciosPage extends StatelessWidget {
  const ServiciosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Layout(
        child: Center(
          child: Text('ServiciosPage'),
        ),
      ),
    );
  }
}
