#' Ventas mensuales de Lucahura Retail Group / Monthly sales
#'
#' Ventas mensuales por tienda y producto de la cadena ficticia Lucahura
#' Retail Group, para el Caso 1 ("La caida de Lucahura"). Cubre 24 meses
#' (enero 2024 a diciembre 2025) para las 9 tiendas del paquete.
#'
#' Monthly sales by store and product for the fictional retail chain
#' Lucahura Retail Group, used in Case 1 ("La caida de Lucahura"). Covers
#' 24 months (January 2024 to December 2025) for the package's 9 stores.
#'
#' @format Un data frame / a data frame con 1296 filas y 5 columnas:
#' \describe{
#'   \item{date}{Primer dia del mes / first day of the month (`Date`).}
#'   \item{store_id}{Identificador de tienda, ver \code{\link{stores}} /
#'     store identifier, see \code{\link{stores}}.}
#'   \item{product_id}{Identificador de producto, ver
#'     \code{\link{products}} / product identifier, see
#'     \code{\link{products}}.}
#'   \item{quantity}{Unidades vendidas en el mes / units sold that month.}
#'   \item{amount}{Monto total vendido en el mes (moneda ficticia) /
#'     total sales amount for the month (fictional currency).}
#' }
#' @source Datos simulados creados para el paquete datamysteries / simulated
#'   data created for the datamysteries package.
"sales"

#' Tiendas de Lucahura Retail Group / Stores
#'
#' Catalogo de las 9 tiendas de Lucahura Retail Group, agrupadas en 3
#' regiones ficticias (North, Central, South).
#'
#' Catalog of Lucahura Retail Group's 9 stores, grouped into 3 fictional
#' regions (North, Central, South).
#'
#' @format Un data frame / a data frame con 9 filas y 4 columnas:
#' \describe{
#'   \item{store_id}{Identificador unico de tienda / unique store
#'     identifier.}
#'   \item{city}{Ciudad ficticia donde opera la tienda / fictional city
#'     where the store operates.}
#'   \item{region}{Region a la que pertenece la tienda: "North",
#'     "Central" o "South" / region the store belongs to.}
#'   \item{manager}{Nombre del gerente de tienda / store manager's name.}
#' }
#' @source Datos simulados creados para el paquete datamysteries / simulated
#'   data created for the datamysteries package.
"stores"

#' Productos de Lucahura Retail Group / Products
#'
#' Catalogo de productos vendidos por Lucahura Retail Group, con su
#' categoria y precio de lista vigente (posterior al ajuste de precios de
#' abril de 2025).
#'
#' Catalog of products sold by Lucahura Retail Group, with category and
#' current list price (after the April 2025 price adjustment).
#'
#' @format Un data frame / a data frame con 6 filas y 3 columnas:
#' \describe{
#'   \item{product_id}{Identificador unico de producto / unique product
#'     identifier.}
#'   \item{category}{Categoria del producto: "Electronics", "Home" o
#'     "Apparel" / product category.}
#'   \item{list_price}{Precio de lista vigente / current list price.}
#' }
#' @source Datos simulados creados para el paquete datamysteries / simulated
#'   data created for the datamysteries package.
"products"

#' Empleados de Lucahura Retail Group / Employees
#'
#' Historial de contratacion y salida de empleados por tienda. Incluye
#' rotacion de base en todas las tiendas y, en las tiendas de la region
#' South, salidas concentradas de vendedores clave entre abril y junio de
#' 2025.
#'
#' Hiring and termination history by store. Includes baseline turnover
#' across all stores and, in the South region's stores, concentrated
#' departures of key salespeople between April and June 2025.
#'
#' @format Un data frame / a data frame con 1 fila por empleado y 4
#'   columnas:
#' \describe{
#'   \item{employee_id}{Identificador unico de empleado / unique employee
#'     identifier.}
#'   \item{store_id}{Tienda donde trabaja(ba) el empleado, ver
#'     \code{\link{stores}} / store where the employee works(ed), see
#'     \code{\link{stores}}.}
#'   \item{hire_date}{Fecha de contratacion / hire date.}
#'   \item{termination_date}{Fecha de salida, o \code{NA} si sigue
#'     activo / termination date, or \code{NA} if still active.}
#' }
#' @source Datos simulados creados para el paquete datamysteries / simulated
#'   data created for the datamysteries package.
"employees"

#' Campanas de marketing de Lucahura Retail Group / Marketing campaigns
#'
#' Presupuesto trimestral de marketing por region, de 2024 a 2025. El
#' presupuesto sigue una tendencia estable y creciente en las tres
#' regiones, sin recortes anomalos.
#'
#' Quarterly marketing budget by region, 2024 to 2025. Budget follows a
#' stable, gently increasing trend across all three regions, with no
#' anomalous cuts.
#'
#' @format Un data frame / a data frame con 24 filas y 5 columnas:
#' \describe{
#'   \item{campaign_id}{Identificador unico de campana / unique campaign
#'     identifier.}
#'   \item{region}{Region de la campana: "North", "Central" o "South" /
#'     campaign region.}
#'   \item{start_date}{Fecha de inicio del trimestre / quarter start
#'     date.}
#'   \item{end_date}{Fecha de fin del trimestre / quarter end date.}
#'   \item{budget}{Presupuesto asignado (moneda ficticia) / budget
#'     assigned (fictional currency).}
#' }
#' @source Datos simulados creados para el paquete datamysteries / simulated
#'   data created for the datamysteries package.
"marketing"

#' Competidores de Lucahura Retail Group / Competitors
#'
#' Apertura de competidores por region. North y Central tienen competencia
#' establecida desde hace anios, sin relacion temporal con ninguna caida
#' de ventas; South tiene un competidor de apertura reciente que coincide
#' con la caida de ventas del Caso 1.
#'
#' Competitor openings by region. North and Central have long-established
#' competitors with no temporal link to any sales drop; South has a
#' recently opened competitor that coincides with Case 1's sales drop.
#'
#' @format Un data frame / a data frame con 3 filas y 3 columnas:
#' \describe{
#'   \item{region}{Region donde opera el competidor / region where the
#'     competitor operates.}
#'   \item{competitor}{Nombre ficticio del competidor / fictional
#'     competitor name.}
#'   \item{opening_date}{Fecha de apertura / opening date.}
#' }
#' @source Datos simulados creados para el paquete datamysteries / simulated
#'   data created for the datamysteries package.
"competitors"
