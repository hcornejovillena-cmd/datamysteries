# datamysteries

[![R CMD check](https://github.com/hcornejovillena-cmd/datamysteries/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/hcornejovillena-cmd/datamysteries/actions/workflows/R-CMD-check.yaml)

`datamysteries` es una coleccion de **casos de negocio ficticios tipo
"misterio"** para aprender R y el tidyverse mediante aprendizaje basado
en casos, pensada para estudiantes de administracion, marketing y
negocios internacionales sin experiencia previa en R.

En vez de datasets genericos (`iris`, `mtcars`), cada caso presenta un
problema de negocio narrado (una caida de ventas, un fraude, una fuga de
clientes...) que se investiga con comandos de R/tidyverse introducidos
progresivamente, descartando hipotesis falsas ("senuelos") hasta llegar
a la causa real.

El objetivo no es solo aprender comandos: es practicar el razonamiento de
un analista de negocios con datos.

## Instalacion

```r
# install.packages("devtools")
devtools::install_github(
  "hcornejovillena-cmd/datamysteries",
  dependencies = TRUE,
  build_vignettes = TRUE
)
```

`build_vignettes = TRUE` es necesario para poder abrir las guias del
caso con `vignette()`. `dependencies = TRUE` instala tambien los paquetes
usados en las guias y ejercicios (`dplyr`, `ggplot2`, `lubridate`,
`stringr`, `tidyr`, `knitr` y `rmarkdown`).

## Como empezar

```r
library(datamysteries)

vignette("caso1-la-caida-de-lucahura", package = "datamysteries")
```

En RStudio, abre la vignette, lee el caso y ejecuta los bloques de codigo
en orden. La solucion no aparece dentro de la guia para preservar la
experiencia de investigacion.

## Caso 1: "La caida de Lucahura"

El gerente regional de **Lucahura Retail Group**, una cadena de retail
ficticia, detecta una caida fuerte de ventas en una de sus tres regiones
durante el tercer trimestre. Como analista de datos, usas R para
descartar hipotesis (subida de precios, recorte de marketing) y llegar a
la causa real combinando varias tablas.

Datasets incluidos:

| Dataset       | Contenido                                              |
|---------------|---------------------------------------------------------|
| `sales`       | Ventas mensuales por tienda y producto                  |
| `stores`      | Catalogo de tiendas y regiones                          |
| `products`    | Catalogo de productos y precio de lista                 |
| `employees`   | Historial de contratacion y salida de personal          |
| `marketing`   | Presupuesto trimestral de marketing por region          |
| `competitors` | Apertura de competidores por region                     |

Para empezar el caso (disponible en espanol e ingles):

```r
library(datamysteries)
vignette("caso1-la-caida-de-lucahura", package = "datamysteries")       # espanol
vignette("case1-the-lucahura-sales-drop", package = "datamysteries")   # english
```

La vignette guia el analisis capitulo a capitulo (`select()`/`filter()`,
`mutate()`/`arrange()`, `group_by()`/`summarize()`, `left_join()`,
`str_detect()`/fechas con `lubridate`, y visualizacion con `ggplot2`)
sin revelar la causa raiz de entrada, para que la deduzcas con tus
propios datos.

Para docentes: el repositorio incluye `solutions/case1_solution.R` con
el analisis completo y la revelacion final de la causa raiz (no se
instala junto con el paquete).

## Para docentes

**Objetivo del Caso 1:** que el estudiante aprenda a formular hipotesis,
cruzar tablas, descartar explicaciones plausibles y cerrar con una
recomendacion ejecutiva basada en datos.

**Publico sugerido:** cursos introductorios de R, estadistica aplicada,
analitica de negocios, marketing analytics o business intelligence.

**Duracion estimada:** 60 a 90 minutos, segun si se trabaja como
demostracion guiada o como ejercicio en grupos.

**Conocimientos previos:** nociones basicas de data frames y ejecucion de
codigo en RStudio. El caso introduce progresivamente los verbos centrales
del tidyverse.

**Comandos cubiertos:** `select()`, `filter()`, `mutate()`, `arrange()`,
`group_by()`, `summarise()`, `left_join()`, fechas con `lubridate`,
busqueda de texto con `stringr` y visualizacion con `ggplot2`.

**Uso recomendado en clase:**

1. Presentar el brief empresarial sin revelar la causa.
2. Pedir a los estudiantes que anoten su hipotesis inicial.
3. Ejecutar la vignette por capitulos, discutiendo evidencia y descarte.
4. Cerrar con la decision ejecutiva final: una intervencion, 60 dias y un
   indicador de seguimiento.

**Advertencia:** `solutions/` contiene spoilers para estudiantes. Esa
carpeta esta pensada para docentes y no se instala con el paquete.

## Escalabilidad

El paquete esta pensado desde el inicio para alojar multiples casos
(ventas, fraude interno, fuga de clientes, campanas fallidas), no solo
el Caso 1, y para adopcion bilingue (espanol/ingles) por otras
universidades.

Para proponer o crear nuevos casos, revisa [CONTRIBUTING.md](CONTRIBUTING.md).

## Estado del proyecto

Version piloto academica. El Caso 1 ya cuenta con datos reproducibles,
vignettes bilingues, solucion docente, tests automatizados y verificacion
con `R CMD check`.

## Licencia

MIT; ver [LICENSE.md](LICENSE.md).
