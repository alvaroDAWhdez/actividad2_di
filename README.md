# ui_kit_dam

Kit de componentes de interfaz para Flutter, con catálogo en Widgetbook.

## Componentes

### QuantityStepper

Selector de cantidad con botones − y + que nunca sale del rango indicado.

```dart
QuantityStepper(
  min: 1,
  max: 8,
  step: 1,
  onChanged: (value) => print(value),
  onLimitReached: (limit) => print(limit),
)
```

| Propiedad | Por defecto | Descripción |
|---|---|---|
| `min` | 0 | Valor mínimo |
| `max` | 10 | Valor máximo |
| `step` | 1 | Incremento por pulsación |
| `initialValue` | `min` | Valor inicial |
| `semanticLabel` | 'Cantidad' | Etiqueta de accesibilidad |
| `decrementTooltip` | 'Restar' | Tooltip del botón − |
| `incrementTooltip` | 'Sumar' | Tooltip del botón + |
| `onChanged` | — | Se emite con el nuevo valor al cambiar |
| `onLimitReached` | — | Se emite al llegar al mínimo o al máximo |

El botón − se desactiva en el mínimo y el botón + en el máximo.

## Catálogo

Para ver los componentes en Widgetbook:

```bash
flutter run -d chrome -t lib/widgetbook/widgetbook.dart
```

## Pruebas

```bash
flutter test
```