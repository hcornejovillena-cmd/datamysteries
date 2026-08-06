## Genera los datasets del Caso 1: "La caida de Lucahura"
##
## Empresa ficticia: Lucahura Retail Group
## 3 regiones x 3 tiendas = 9 tiendas, 24 meses (2024-01 a 2025-12)
##
## Causa real incrustada: rotacion de personal clave + apertura de un
## competidor en la region "South", ambas en el segundo trimestre de 2025,
## que en conjunto explican la caida de ventas del Q3 2025 en esa region.
##
## Senuelos incrustados (no explican la caida regional):
## - Subida de precios: ocurre en TODAS las regiones por igual en 2025-04,
##   por lo que no explica una caida especifica de una sola region.
## - Presupuesto de marketing: sigue una tendencia estable/creciente en
##   todas las regiones, incluida South; no hay recorte que coincida con
##   la caida.
## - Competidores antiguos en North y Central, sin relacion temporal con
##   ninguna caida de ventas (para distinguir correlacion de causalidad).

library(dplyr)
library(tidyr)
library(lubridate)

set.seed(2026)

# ---- stores -----------------------------------------------------------

stores <- tibble::tribble(
  ~store_id, ~city,        ~region,   ~manager,
  "ST01",    "Rivermoor",  "North",   "Laura Mendez",
  "ST02",    "Fairhaven",  "North",   "James Cole",
  "ST03",    "Ashcombe",   "North",   "Priya Shah",
  "ST04",    "Oakbridge",  "Central", "Wei Zhang",
  "ST05",    "Milltown",   "Central", "Carlos Ibarra",
  "ST06",    "Bellcrest",  "Central", "Fatima Noor",
  "ST07",    "Stonefield", "South",   "Emma Clarke",
  "ST08",    "Cedarvale",  "South",   "Diego Santos",
  "ST09",    "Thornwood",  "South",   "Anna Kowalski"
)

# ---- products -----------------------------------------------------------
# list_price = precio actual (post subida de precios de 2025-04)

products <- tibble::tribble(
  ~product_id, ~category,     ~list_price,
  "P01",       "Electronics", 129.90,
  "P02",       "Electronics", 349.00,
  "P03",       "Home",        59.90,
  "P04",       "Home",        89.50,
  "P05",       "Apparel",     39.90,
  "P06",       "Apparel",     69.90
)

price_increase_date <- as.Date("2025-04-01")
price_increase_factor <- 1.08

# ---- sales -----------------------------------------------------------

months <- seq(as.Date("2024-01-01"), as.Date("2025-12-01"), by = "1 month")

base_quantity <- c(P01 = 60, P02 = 25, P03 = 90, P04 = 45, P05 = 140, P06 = 100)

sales <- tidyr::expand_grid(date = months, store_id = stores$store_id,
                             product_id = products$product_id) |>
  dplyr::left_join(stores, by = "store_id") |>
  dplyr::left_join(products, by = "product_id") |>
  dplyr::mutate(
    month_index = interval(as.Date("2024-01-01"), date) %/% months(1),
    # tendencia de crecimiento suave + estacionalidad de fin de ano
    trend = 1 + 0.006 * month_index,
    seasonality = 1 + 0.25 * (month(date) %in% c(11, 12)),
    # causa real: caida en South a partir de julio 2025 (mes 18),
    # por rotacion de personal clave + apertura de competidor
    south_drop = dplyr::if_else(
      region == "South" & date >= as.Date("2025-07-01"),
      0.60,
      1
    ),
    noise = stats::rnorm(dplyr::n(), mean = 1, sd = 0.05),
    quantity = pmax(0, round(base_quantity[product_id] * trend * seasonality *
                                south_drop * noise)),
    unit_price = dplyr::if_else(date >= price_increase_date,
                                 list_price,
                                 round(list_price / price_increase_factor, 2)),
    amount = round(quantity * unit_price, 2)
  ) |>
  dplyr::select(date, store_id, product_id, quantity, amount) |>
  dplyr::arrange(date, store_id, product_id)

# ---- employees -----------------------------------------------------------
# Rotacion base (normal) en todas las tiendas + salida concentrada de
# vendedores clave en las 3 tiendas de South entre abril y junio de 2025.

make_baseline_employees <- function(store_id, n = 5) {
  hire_dates <- as.Date("2024-01-01") - sample(200:1200, n, replace = TRUE)
  # ~20% de rotacion normal, esparcida en todo el periodo, sin patron
  termination_dates <- as.Date(NA)
  termination_dates <- sample(
    c(rep(NA, ceiling(n * 0.8)),
      as.character(sample(seq(as.Date("2024-02-01"), as.Date("2025-11-01"),
                               by = "day"), floor(n * 0.2)))),
    n
  )
  tibble::tibble(
    store_id = store_id,
    hire_date = hire_dates,
    termination_date = as.Date(termination_dates)
  )
}

baseline_employees <- dplyr::bind_rows(
  lapply(stores$store_id, make_baseline_employees)
)

# vendedores clave de South que renuncian justo antes de la caida
key_departures <- tibble::tribble(
  ~store_id, ~hire_date,              ~termination_date,
  "ST07",    as.Date("2021-03-15"),   as.Date("2025-04-18"),
  "ST07",    as.Date("2022-06-01"),   as.Date("2025-05-30"),
  "ST08",    as.Date("2020-11-10"),   as.Date("2025-05-05"),
  "ST09",    as.Date("2021-08-20"),   as.Date("2025-06-10"),
  "ST09",    as.Date("2022-01-05"),   as.Date("2025-06-20")
)

employees <- dplyr::bind_rows(baseline_employees, key_departures) |>
  dplyr::arrange(store_id, hire_date) |>
  dplyr::mutate(employee_id = sprintf("E%03d", dplyr::row_number())) |>
  dplyr::select(employee_id, store_id, hire_date, termination_date)

# ---- marketing -----------------------------------------------------------
# Presupuesto trimestral por region, con leve crecimiento anual y
# estacionalidad de fin de ano -- sin recorte anomalo en ninguna region,
# para descartar esta hipotesis como causa de la caida en South.

quarters <- tibble::tribble(
  ~start_date,             ~end_date,
  as.Date("2024-01-01"), as.Date("2024-03-31"),
  as.Date("2024-04-01"), as.Date("2024-06-30"),
  as.Date("2024-07-01"), as.Date("2024-09-30"),
  as.Date("2024-10-01"), as.Date("2024-12-31"),
  as.Date("2025-01-01"), as.Date("2025-03-31"),
  as.Date("2025-04-01"), as.Date("2025-06-30"),
  as.Date("2025-07-01"), as.Date("2025-09-30"),
  as.Date("2025-10-01"), as.Date("2025-12-31")
)

base_budget <- c(North = 18000, Central = 15000, South = 16000)

marketing <- tidyr::expand_grid(quarters, region = names(base_budget)) |>
  dplyr::mutate(
    quarter_index = dplyr::row_number(),
    .by = region
  ) |>
  dplyr::mutate(
    seasonal_bump = 1 + 0.15 * (lubridate::month(start_date) == 10),
    budget = round(base_budget[region] * (1 + 0.03 * quarter_index) *
                     seasonal_bump * stats::runif(dplyr::n(), 0.97, 1.03), -1)
  ) |>
  dplyr::arrange(start_date, region) |>
  dplyr::mutate(campaign_id = sprintf("CMP%02d", dplyr::row_number())) |>
  dplyr::select(campaign_id, region, start_date, end_date, budget)

# ---- competitors -----------------------------------------------------------
# South: apertura reciente que coincide con la caida (causa real).
# North y Central: competencia antigua y establecida, sin relacion temporal
# con ninguna caida de ventas (distinguir correlacion de causalidad).

competitors <- tibble::tribble(
  ~region,   ~competitor,        ~opening_date,
  "North",   "ValueMart",        as.Date("2021-03-01"),
  "Central", "QuickBuy",         as.Date("2023-09-01"),
  "South",   "MaxSave Express",  as.Date("2025-06-01")
)

# ---- guardar como datos del paquete ----------------------------------

usethis::use_data(sales, overwrite = TRUE)
usethis::use_data(stores, overwrite = TRUE)
usethis::use_data(products, overwrite = TRUE)
usethis::use_data(employees, overwrite = TRUE)
usethis::use_data(marketing, overwrite = TRUE)
usethis::use_data(competitors, overwrite = TRUE)
