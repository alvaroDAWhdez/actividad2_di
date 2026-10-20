## 1.1.0

- Añadido `QuantityStepper`: selector de cantidad con botones − y +.
- Nuevas propiedades: `min`, `max`, `step`, `initialValue`, `semanticLabel`,
  `decrementTooltip` e `incrementTooltip`.
- Nuevos eventos: `onChanged` y `onLimitReached`, con el enum `StepperLimit`
  y el typedef `LimitReached`.
- Nueva función pura `nextStepperValue`.
- Pruebas unitarias, de widget y golden.
- Documentación con `///` y regla `public_member_api_docs`.