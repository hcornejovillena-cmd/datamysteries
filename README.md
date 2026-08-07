# datamysteries

<img src="man/figures/logo.png" align="right" width="150" alt="datamysteries logo"/>

![version](https://img.shields.io/badge/version-0.1.0-blue)
![R](https://img.shields.io/badge/R-%3E%3D%204.1.0-blue)
![license](https://img.shields.io/badge/license-MIT-green)
![lang](https://img.shields.io/badge/lang-ES%20%7C%20EN-orange)
![lifecycle](https://img.shields.io/badge/lifecycle-pilot-yellow)
[![release](https://img.shields.io/github/v/release/hcornejovillena-cmd/datamysteries?label=release)](https://github.com/hcornejovillena-cmd/datamysteries/releases)
[![R CMD check](https://github.com/hcornejovillena-cmd/datamysteries/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/hcornejovillena-cmd/datamysteries/actions/workflows/R-CMD-check.yaml)

`datamysteries` es una coleccion de **casos ficticios tipo "misterio"**
para aprender R y el tidyverse mediante aprendizaje basado en casos.
Cada caso plantea una situacion aplicada que debe investigarse con datos,
descartando hipotesis falsas ("senuelos") hasta llegar a una explicacion
sostenida por evidencia.

En vez de datasets genericos (`iris`, `mtcars`), el paquete propone
historias investigables: una caida de ventas, un fraude, una fuga de
clientes, una anomalia ambiental, un problema operativo, un caso de salud
publica o cualquier otro escenario donde los datos permitan reconstruir
que ocurrio.

El objetivo no es solo aprender comandos: es practicar razonamiento
analitico con datos en contextos reales o verosimiles.

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
recomendacion basada en datos.

**Publico sugerido:** cursos introductorios de R, estadistica aplicada,
ciencia de datos, analitica de negocios, investigacion aplicada o
metodologia cuantitativa en distintas disciplinas.

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

El paquete esta pensado desde el inicio para alojar multiples casos y no
solo el Caso 1. Aunque Lucahura es un caso de negocios, la misma
arquitectura puede adaptarse a fraudes, investigaciones policiales,
ingenieria, ambiente, salud publica, enfermeria, educacion u otros campos
donde aprender R tenga mas sentido a partir de una pregunta aplicada.

Para proponer o crear nuevos casos, revisa [CONTRIBUTING.md](CONTRIBUTING.md).

## Estado del proyecto

Version piloto academica. El Caso 1 ya cuenta con datos reproducibles,
vignettes bilingues, solucion docente, tests automatizados y verificacion
con `R CMD check`.

## Licencia

MIT; ver [LICENSE.md](LICENSE.md).
