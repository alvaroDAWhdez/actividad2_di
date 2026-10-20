import 'package:flutter/material.dart';

/// Límite que ha alcanzado un [QuantityStepper].
enum StepperLimit {
  /// Se ha llegado al valor mínimo.
  min,

  /// Se ha llegado al valor máximo.
  max,
}

/// Función que se invoca cuando un [QuantityStepper] alcanza un límite.
///
/// Recibe el [StepperLimit] alcanzado.
typedef LimitReached = void Function(StepperLimit limit);

/// Calcula el siguiente valor sumando [delta] a [current] sin salir del
/// rango [min]..[max].
///
/// Devuelve [min] si el resultado queda por debajo y [max] si queda por
/// encima.
int nextStepperValue({
  required int current,
  required int delta,
  required int min,
  required int max,
}) {
  final next = current + delta;
  if (next < min) return min;
  if (next > max) return max;
  return next;
}

/// Selector de cantidad con un botón − y un botón +.
///
/// Muestra el valor actual entre ambos botones y nunca lo deja salir del
/// rango [min]..[max].
///
/// Ejemplo de uso:
///
/// ```dart
/// QuantityStepper(
///   min: 1,
///   max: 8,
///   onChanged: (value) => print('Cantidad: $value'),
///   onLimitReached: (limit) => print('Límite: $limit'),
/// )
/// ```
class QuantityStepper extends StatefulWidget {
  /// Crea un selector de cantidad.
  ///
  /// En modo debug lanza un error si `min >= max`, si `step <= 0` o si
  /// [initialValue] queda fuera del rango.
  const QuantityStepper({
    super.key,
    this.min = 0,
    this.max = 10,
    this.step = 1,
    int? initialValue,
    this.semanticLabel = 'Cantidad',
    this.decrementTooltip = 'Restar',
    this.incrementTooltip = 'Sumar',
    this.onChanged,
    this.onLimitReached,
  })  : initialValue = initialValue ?? min,
        assert(min < max, 'min debe ser menor que max'),
        assert(step > 0, 'step debe ser mayor que 0'),
        assert(
          (initialValue ?? min) >= min && (initialValue ?? min) <= max,
          'initialValue debe estar entre min y max',
        );

  /// Valor mínimo permitido. Por defecto 0.
  final int min;

  /// Valor máximo permitido. Por defecto 10.
  final int max;

  /// Cantidad que suma o resta cada pulsación. Por defecto 1.
  final int step;

  /// Valor con el que empieza. Por defecto es igual a [min].
  final int initialValue;

  /// Etiqueta de accesibilidad del componente. Por defecto 'Cantidad'.
  final String semanticLabel;

  /// Tooltip del botón −. Por defecto 'Restar'.
  final String decrementTooltip;

  /// Tooltip del botón +. Por defecto 'Sumar'.
  final String incrementTooltip;

  /// Se emite con el nuevo valor cada vez que este cambia.
  ///
  /// No se emite si la pulsación no modifica el valor.
  final ValueChanged<int>? onChanged;

  /// Se emite cuando el valor llega al mínimo o al máximo.
  ///
  /// No se emite si la pulsación no modifica el valor.
  final LimitReached? onLimitReached;

  @override
  State<QuantityStepper> createState() => _QuantityStepperState();
}

class _QuantityStepperState extends State<QuantityStepper> {
  late int _value;

  int _clamped(int v) => nextStepperValue(
        current: v,
        delta: 0,
        min: widget.min,
        max: widget.max,
      );

  @override
  void initState() {
    super.initState();
    _value = _clamped(widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant QuantityStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = _clamped(_value);
  }

  void _change(int delta) {
    final next = nextStepperValue(
      current: _value,
      delta: delta,
      min: widget.min,
      max: widget.max,
    );
    if (next == _value) return;
    setState(() => _value = next);
    widget.onChanged?.call(next);
    if (next == widget.max) {
      widget.onLimitReached?.call(StepperLimit.max);
    } else if (next == widget.min) {
      widget.onLimitReached?.call(StepperLimit.min);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel,
      value: '$_value',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            tooltip: widget.decrementTooltip,
            onPressed: _value > widget.min ? () => _change(-widget.step) : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text('$_value'),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: widget.incrementTooltip,
            onPressed: _value < widget.max ? () => _change(widget.step) : null,
          ),
        ],
      ),
    );
  }
}