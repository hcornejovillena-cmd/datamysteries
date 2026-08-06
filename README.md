# datamysteries

`datamysteries` es una coleccion de **casos de negocio ficticios tipo
"misterio"** para aprender R y el tidyverse mediante aprendizaje basado
en casos, pensada para estudiantes de administracion, marketing y
negocios internacionales sin experiencia previa en R.

En vez de datasets genericos (`iris`, `mtcars`), cada caso presenta un
problema de negocio narrado (una caida de ventas, un fraude, una fuga de
clientes...) que se investiga con comandos de R/tidyverse introducidos
progresivamente, descartando hipotesis falsas ("senuelos") hasta llegar
a la causa real.

## Instalacion

```r
# install.packages("devtools")
devtools::install_github("hcornejovillena-cmd/datamysteries")
```

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

Para empezar el caso:

```r
library(datamysteries)
vignette("caso1-la-caida-de-lucahura", package = "datamysteries")
```

La vignette guia el analisis capitulo a capitulo (`select()`/`filter()`,
`mutate()`/`arrange()`, `group_by()`/`summarize()`, `left_join()`,
`str_detect()`/fechas con `lubridate`, y visualizacion con `ggplot2`)
sin revelar la causa raiz de entrada, para que la deduzcas con tus
propios datos.

Para docentes: el repositorio incluye `solutions/case1_solution.R` con
el analisis completo y la revelacion final de la causa raiz (no se
instala junto con el paquete).

## Escalabilidad

El paquete esta pensado desde el inicio para alojar multiples casos
(ventas, fraude interno, fuga de clientes, campanas fallidas), no solo
el Caso 1, y para adopcion bilingue (espanol/ingles) por otras
universidades.

## Licencia

MIT — ver [LICENSE.md](LICENSE.md).
