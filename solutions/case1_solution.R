## ============================================================
## SOLUCION DOCENTE -- Caso 1: "La caida de Lucahura"
## datamysteries :: solutions/case1_solution.R
##
## ADVERTENCIA / SPOILERS: este archivo contiene la resolucion completa
## del caso, incluida la causa raiz real. Esta pensado para docentes que
## preparan la clase o corrigen el ejercicio, no para estudiantes.
## No se instala con el paquete (ver .Rbuildignore); solo vive en el
## repositorio de GitHub.
##
## Complementa a vignettes/caso1-la-caida-de-lucahura.Rmd, que guia el
## mismo analisis sin declarar la conclusion final.
## ============================================================

library(datamysteries)
library(dplyr)
library(tidyr)
library(ggplot2)
library(lubridate)
library(stringr)

## ---- Hipotesis 1 (senuelo): subida de precios -----------------------
## products solo tiene un precio de lista global (sin variacion por
## region), y el precio unitario calculado desde `sales` (amount/quantity)
## sube ~8% en abril de 2025 -- pero en las TRES regiones por igual.
## Conclusion: la subida de precio es real, pero no puede explicar una
## caida que ocurre solo en una region.

sales |>
  dplyr::left_join(stores, by = "store_id") |>
  dplyr::mutate(unit_price = amount / quantity,
                year_month = format(date, "%Y-%m")) |>
  dplyr::group_by(region, year_month) |>
  dplyr::summarise(avg_price = mean(unit_price), .groups = "drop") |>
  tidyr::pivot_wider(names_from = region, values_from = avg_price) |>
  print(n = 30)

## ---- Hipotesis 2 (senuelo): recorte de presupuesto de marketing -----
## El presupuesto de South sigue la misma tendencia creciente que North
## y Central en todos los trimestres de 2025, sin ningun recorte.
## Conclusion: descartada.

marketing |>
  dplyr::filter(start_date >= as.Date("2025-01-01")) |>
  dplyr::arrange(region, start_date) |>
  print(n = 30)

## ---- Confirmar el patron: la caida es especifica de South -----------

ventas_por_region <- sales |>
  dplyr::left_join(stores, by = "store_id") |>
  dplyr::mutate(year_month = format(date, "%Y-%m")) |>
  dplyr::group_by(region, year_month) |>
  dplyr::summarise(total = sum(amount), .groups = "drop")

ventas_por_region |>
  tidyr::pivot_wider(names_from = region, values_from = total) |>
  print(n = 30)

## La caida es visible a partir de 2025-07 y es exclusiva de South;
## North y Central se mantienen estables o crecen.

## ---- Hipotesis 3 (causa real, parte 1): rotacion de personal --------
## South concentra 8 renuncias en 2025 (vs. 3 en Central y 0 en North),
## con salidas de vendedores clave entre abril y junio de 2025 --
## justo antes de que caigan las ventas de julio en adelante.

employees |>
  dplyr::left_join(stores, by = "store_id") |>
  dplyr::filter(!is.na(termination_date), termination_date >= as.Date("2025-01-01")) |>
  dplyr::arrange(region, termination_date) |>
  print(n = 30)

## ---- Hipotesis 4 (causa real, parte 2): apertura de competidor ------
## South es la unica region con un competidor de apertura reciente
## (MaxSave Express, 2025-06-01). North (ValueMart, 2021) y Central
## (QuickBuy, 2023) tienen competencia antigua y establecida, sin
## relacion temporal con ninguna caida de ventas.

competitors |>
  dplyr::arrange(opening_date) |>
  print()

## ---- Causa raiz real (revelacion) ------------------------------------
## La caida de ventas en South a partir de julio de 2025 es el resultado
## COMBINADO de:
##   1) la salida de varios vendedores clave entre abril y junio de 2025
##      (perdida de relaciones con clientes y de conocimiento de venta), y
##   2) la apertura de un competidor directo (MaxSave Express) en junio
##      de 2025 en la misma region, que capturo parte de esa demanda.
## Ninguna de las dos causas por si sola explica una caida de esta
## magnitud tan rapido; la combinacion si.
##
## La subida de precios y el presupuesto de marketing son SENUELOS: son
## eventos reales en los datos, pero ocurren de forma pareja en las tres
## regiones, por lo que no pueden explicar un problema exclusivo de South.

resumen_south <- sales |>
  dplyr::left_join(stores, by = "store_id") |>
  dplyr::filter(region == "South") |>
  dplyr::group_by(date) |>
  dplyr::summarise(ventas_mes = sum(amount), .groups = "drop") |>
  dplyr::mutate(periodo = dplyr::if_else(date < as.Date("2025-07-01"), "antes", "despues")) |>
  dplyr::group_by(periodo) |>
  dplyr::summarise(ventas_promedio_mes = mean(ventas_mes), .groups = "drop")

resumen_south

## Grafico de apoyo para la presentacion del hallazgo

sales |>
  dplyr::left_join(stores, by = "store_id") |>
  dplyr::group_by(region, date) |>
  dplyr::summarise(total = sum(amount), .groups = "drop") |>
  ggplot2::ggplot(ggplot2::aes(x = date, y = total, color = region)) +
  ggplot2::geom_line(linewidth = 1) +
  ggplot2::geom_vline(xintercept = as.numeric(as.Date("2025-06-01")),
                       linetype = "dashed", color = "grey40") +
  ggplot2::annotate("text", x = as.Date("2025-06-01"), y = Inf,
                     label = "Apertura MaxSave Express + salidas clave",
                     vjust = 2, hjust = -0.02, size = 3, color = "grey40") +
  ggplot2::labs(title = "Ventas mensuales por region -- causa raiz marcada",
                x = NULL, y = "Monto vendido", color = "Region") +
  ggplot2::theme_minimal()

## ---- Recomendacion sugerida para el gerente regional -----------------
## - Corto plazo: reforzar el equipo de ventas de South (retencion y/o
##   contratacion) y lanzar una respuesta comercial focalizada frente a
##   MaxSave Express (South especificamente, no un recorte/aumento
##   generico de precio o marketing a nivel compania).
## - Indicador de seguimiento: ventas mensuales promedio de South y tasa
##   de recuperacion frente al promedio de North/Central durante los
##   proximos 60 dias. Tambien conviene monitorear rotacion del equipo de
##   ventas para confirmar que la capacidad comercial se estabiliza.
## - Mediano plazo: revisar por que se fueron los vendedores clave
##   (compensacion, carga de trabajo, clima laboral) para evitar que se
##   repita el patron en otras regiones.
