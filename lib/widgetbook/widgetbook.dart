// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../ui_kit_dam.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: [
        WidgetbookCategory(
          name: 'UI Kit DAM',
          children: [
            WidgetbookComponent(
              name: 'QuantityStepper',
              useCases: [
                WidgetbookUseCase(
                  name: 'Por defecto',
                  builder: (context) => const Center(
                    child: QuantityStepper(),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Configurable',
                  builder: (context) => Center(
                    child: QuantityStepper(
                      min: context.knobs.int.slider(
                        label: 'min',
                        initialValue: 0,
                        min: 0,
                        max: 5,
                      ),
                      max: context.knobs.int.slider(
                        label: 'max',
                        initialValue: 10,
                        min: 6,
                        max: 20,
                      ),
                      step: context.knobs.int.slider(
                        label: 'step',
                        initialValue: 1,
                        min: 1,
                        max: 5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}