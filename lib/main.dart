// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';

import 'ui_kit_dam.dart';

void main() {
  runApp(const MaterialApp(home: TestScreen()));
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prueba QuantityStepper')),
      body: Center(
        child: QuantityStepper(
          max: 5,
          onLimitReached: (limit) {
            if (limit == StepperLimit.max) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Has llegado al máximo')),
              );
            }
          },
        ),
      ),
    );
  }
}