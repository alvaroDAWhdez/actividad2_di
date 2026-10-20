import 'package:actividad2/ui_kit_dam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('nextStepperValue', () {
    test('suma dentro del rango', () {
      expect(nextStepperValue(current: 3, delta: 1, min: 0, max: 10), 4);
    });

    test('resta dentro del rango', () {
      expect(nextStepperValue(current: 3, delta: -1, min: 0, max: 10), 2);
    });

    test('no pasa del máximo', () {
      expect(nextStepperValue(current: 10, delta: 1, min: 0, max: 10), 10);
    });

    test('no baja del mínimo', () {
      expect(nextStepperValue(current: 0, delta: -1, min: 0, max: 10), 0);
    });

    test('recorta si el salto supera el límite', () {
      expect(nextStepperValue(current: 9, delta: 5, min: 0, max: 10), 10);
    });
  });

  group('QuantityStepper', () {
    testWidgets('sumar muestra el nuevo valor y emite onChanged',
        (tester) async {
      int? recibido;
      await tester.pumpWidget(
        _wrap(QuantityStepper(onChanged: (v) => recibido = v)),
      );

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
      expect(recibido, 1);
    });

    testWidgets('el botón − está desactivado en el mínimo', (tester) async {
      await tester.pumpWidget(_wrap(const QuantityStepper()));

      final boton = tester.widget<IconButton>(
        find.widgetWithIcon(IconButton, Icons.remove),
      );
      expect(boton.onPressed, isNull);
    });

    testWidgets('onLimitReached recibe StepperLimit.max', (tester) async {
      StepperLimit? limite;
      await tester.pumpWidget(
        _wrap(
          QuantityStepper(
            max: 2,
            initialValue: 1,
            onLimitReached: (l) => limite = l,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(limite, StepperLimit.max);
    });

    testWidgets('golden con valor 5', (tester) async {
      await tester.pumpWidget(_wrap(const QuantityStepper(initialValue: 5)));

      await expectLater(
        find.byType(QuantityStepper),
        matchesGoldenFile('goldens/quantity_stepper_5.png'),
      );
    });
  });
}