# datamysteries — Plan del proyecto

## 1. Visión general

**Nombre del paquete:** `datamysteries`
**Formato:** Paquete de R (estilo `reclues`), instalable vía `devtools::install_github()`
**Licencia:** MIT (abierta, permite adaptación por otras universidades)
**Idioma:** Bilingüe desde el diseño (español / inglés)
**Nombre verificado:** sin conflictos en CRAN ni GitHub al momento de la búsqueda (agosto 2026)

### Propósito
Ofrecer una colección de **casos de negocio ficticios tipo "misterio"** para enseñar R y tidyverse mediante aprendizaje basado en casos, dirigido a estudiantes de administración, marketing y negocios internacionales — es decir, público que aprende mejor con narrativa y contexto empresarial que con datasets genéricos (iris, mtcars, etc.).

### Público objetivo
- Estudiantes de pregrado en carreras de gestión (administración, marketing, negocios internacionales)
- Cursos de estadística aplicada a la gestión empresarial
- Nivel de entrada: sin experiencia previa en R
- Escalable a otras universidades e idiomas

### Diferenciador frente a `reclues` / SQL Murder Mystery
- Contexto 100% de negocios (ventas, marketing, RRHH, competencia) en lugar de crimen policial
- Pensado como **colección de casos**, no uno solo — permite agregar nuevos misterios (fraude, churn, campañas) sin crear un paquete nuevo
- Diseñado explícitamente para progresión pedagógica: cada capítulo introduce un comando nuevo de R/tidyverse
- Bilingüe desde el origen, con miras a adopción internacional

---

## 2. Estructura del paquete (técnica)

```
datamysteries/
├── DESCRIPTION       # metadatos: nombre, versión, autor, licencia
├── NAMESPACE         # generado automáticamente
├── R/
│   └── data.R        # documentación roxygen2 de cada dataset
├── data/
│   ├── ventas.rda
│   ├── tiendas.rda
│   ├── productos.rda
│   ├── empleados.rda
│   ├── marketing.rda
│   └── competencia.rda
├── data-raw/         # scripts que generan los .rda (no se distribuyen)
├── vignettes/        # historia del caso + guía paso a paso (ES/EN)
├── LICENSE
└── README.md
```

### Herramientas de desarrollo
- `usethis` — estructura de carpetas y archivos
- `devtools` — build, check, load durante desarrollo
- `roxygen2` — documentación automática de datasets

### Flujo de trabajo
1. `usethis::create_package("datamysteries")`
2. Diseñar datasets como data frames en R
3. `usethis::use_data(ventas, tiendas, ...)`
4. Documentar cada dataset con comentarios roxygen en `R/data.R`
5. `devtools::document()` → genera `.Rd` y `NAMESPACE`
6. `devtools::check()` → valida el paquete
7. `usethis::use_github()` → publicar
8. Instalación por terceros: `devtools::install_github("usuario/datamysteries")`

---

## 3. Caso 1: "La caída de Lucahura"

### Premisa narrativa
El gerente regional de **Lucahura Retail Group**, una cadena de retail ficticia sin atadura geográfica específica, detecta una caída fuerte en las ventas de una región durante el tercer trimestre. Circulan varias hipótesis/rumores sobre la causa. Los estudiantes, en el rol de analistas de datos, deben usar R para descartar hipótesis falsas ("señuelos") y encontrar la causa real — incluyendo una posible causa oculta detrás de la más evidente (inspirado en la estructura de "cerebro intelectual" del SQL Murder Mystery).

### Alcance de los datasets
- **Rango temporal:** 2 años de datos mensuales por tienda (24 meses), lo que permite comparar el Q3 de la caída contra el mismo trimestre del año anterior para el hallazgo final.
- **Tamaño:** 3 regiones x 3 tiendas = 9 tiendas en total. Suficiente para contrastar la región afectada contra las demás sin abrumar a principiantes al inspeccionar con `View()`/`glimpse()`.

### Datasets planificados

Nombres de tablas y columnas en inglés (convención tidyverse), narrativa y documentación bilingües (ES/EN).

| Tabla | Contenido |
|---|---|
| `sales` | date, store_id, product_id, quantity, amount |
| `stores` | store_id, city, region, manager |
| `products` | product_id, category, list_price |
| `employees` | employee_id, store_id, hire_date, termination_date |
| `marketing` | campaign_id, region, start_date, end_date, budget |
| `competitors` | region, competitor, opening_date |

### Hipótesis a investigar (mezcla de señuelos y causa real)
1. Subida de precios → revisar `products` + `sales` (señuelo)
2. Recorte de presupuesto de marketing → revisar `marketing` (señuelo)
3. Rotación de personal (renuncia de vendedores clave) → revisar `employees`
4. Apertura de competidor cercano → revisar `competitors`
5. **Causa raíz real:** combinación de rotación de personal + apertura de competidor (mientras que precio y marketing resultan ser señuelos)

### Estructura pedagógica por capítulos (ritmo flexible, no atado a un número fijo de semanas/sesiones)

El progreso está definido por capítulo/comando nuevo, no por calendario — cada docente decide cuántos capítulos cubre por sesión según el ritmo de su curso.

| Capítulo | Comando(s) nuevo(s) de R | Momento de la historia |
|---|---|---|
| Prólogo | `library()`, carga de datos, `glimpse()`, `View()` | Contexto de la empresa y presentación del caso |
| Cap. 1 | `select()`, `filter()`, operadores lógicos | Descartar hipótesis obvias (¿subieron precios?) |
| Cap. 2 | `mutate()`, `arrange()` | Calcular variaciones % de ventas, ordenar por caída |
| Cap. 3 | `group_by()` + `summarize()` | Comparar promedios por tienda/región |
| Cap. 4 | `left_join()` (join simple) | Cruzar ventas con datos de empleados (rotación) |
| Cap. 5 | `str_detect()`, fechas básicas (`lubridate`) | Cruzar con apertura de competencia |
| Cap. 6 | `ggplot2` básico (`geom_line`, `geom_col`) | Visualizar la tendencia y presentar hallazgo |
| Cap. final | Repaso + joins múltiples | Revelar la causa raíz real |

### Formato del documento
Igual que el modelo de referencia (PDF de "Aprende R y tidyverse mientras resuelves un crimen"): pasos numerados, bloque de código, sección "Hallazgo" tras cada paso, y conclusión final. Cada capítulo cierra con una pregunta de reflexión de negocio (ej. "¿qué recomendarías al gerente?"), conectando el análisis estadístico con la toma de decisiones — clave para la audiencia de gestión empresarial.

---

## 4. Escalabilidad y publicación

- **Estructura de colección**: el paquete está pensado desde el inicio para alojar múltiples casos (ventas, fraude interno, fuga de clientes/churn, campaña de marketing fallida), no solo el actual
- **Bilingüe (ES/EN)**: documentación, nombres de columnas y narrativa pensados para traducción/adaptación
- **Licencia abierta (MIT)**: permite que otras universidades usen y adapten el material libremente
- **Documentación separada de la solución**: README + viñeta sin spoilers, más un archivo `solution.R` aparte para docentes
- **Niveles de dificultad**: mismo dataset con una "versión básica" (la actual) y una "versión avanzada" con más tablas/joins para cursos posteriores
- **Nombre y branding**: resuelto — empresa ficticia "Lucahura Retail Group", sin atadura geográfica específica, facilita adopción internacional

---

## 5. Decisiones pendientes

Todas las decisiones de planificación quedaron resueltas. Siguiente paso: ejecutar el flujo de trabajo de la sección 2 (skeleton del paquete → diseño y generación de los datasets con las pistas falsas y la causa real incrustadas → documentación roxygen2 → redacción de la vignette/documento narrativo).

- [x] Nombre definitivo de la empresa ficticia del Caso 1: **Lucahura Retail Group**
- [x] Nombre definitivo del repositorio/paquete: **datamysteries**
- [x] Título final del Caso 1: **"La caída de Lucahura"**
- [x] Alcance de los datasets: 2 años de datos mensuales, 3 regiones x 3 tiendas (9 tiendas)
- [x] Definir orden de desarrollo: **paquete primero** (datasets + documentación roxygen2), documento narrativo/vignette después
- [x] Idioma de nombres de tablas/columnas: **inglés** (convención tidyverse), narrativa y documentación bilingües (ES/EN)
