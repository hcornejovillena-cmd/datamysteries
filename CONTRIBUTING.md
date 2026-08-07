# Contribuir nuevos casos

`datamysteries` esta pensado para crecer caso por caso. Cada nuevo caso
debe funcionar como una unidad pedagogica completa: historia, datos,
guia para estudiantes, solucion docente y tests minimos.

## Estructura recomendada

Para un nuevo caso, usa este patron:

- `data-raw/caseN_nombre.R`: script reproducible que genera los datos.
- `data/*.rda`: datasets instalables con el paquete.
- `R/data.R`: documentacion roxygen de cada dataset nuevo.
- `vignettes/casoN-nombre.Rmd`: guia para estudiantes en espanol.
- `vignettes/caseN-name.Rmd`: guia equivalente en ingles, si aplica.
- `solutions/caseN_solution.R`: solucion docente, fuera del paquete instalado.
- `tests/testthat/test-caseN-data.R`: tests de dimensiones, columnas y llaves.

El paquete incluye moldes en `inst/templates/case-template/` para iniciar
estos archivos sin partir desde cero.

## Checklist antes de subir cambios

1. Ejecutar el script de `data-raw/` y regenerar los `.rda`.
2. Actualizar `R/data.R` con dimensiones, columnas y descripcion.
3. Regenerar `man/` con roxygen2 si se modifico documentacion.
4. Agregar o actualizar vignettes.
5. Agregar tests de integridad para los nuevos datasets.
6. Ejecutar `R CMD build` y `R CMD check`.

## Criterios de calidad pedagogica

- El caso debe partir de una pregunta de negocio clara.
- Debe incluir al menos dos hipotesis falsas razonables.
- La causa raiz no debe revelarse al inicio de la vignette.
- Las tablas deben conectarse por llaves simples y visibles.
- Los comandos de R deben introducirse progresivamente.
- La solucion docente debe explicar que evidencia descarta cada hipotesis.

## Criterios de calidad tecnica

- Los datos deben ser reproducibles desde `data-raw/`.
- Los nombres de columnas deben ser consistentes y descriptivos.
- Cada dataset debe tener documentacion en `R/data.R`.
- Las vignettes deben renderizar sin errores.
- `R CMD check --as-cran` debe terminar sin errores.
