test_that("Case 1 datasets keep their expected shapes", {
  expect_equal(dim(sales), c(1296L, 5L))
  expect_equal(dim(stores), c(9L, 4L))
  expect_equal(dim(products), c(6L, 3L))
  expect_equal(dim(employees), c(50L, 4L))
  expect_equal(dim(marketing), c(24L, 5L))
  expect_equal(dim(competitors), c(3L, 3L))
})

test_that("Case 1 datasets keep their expected columns", {
  expect_named(sales, c("date", "store_id", "product_id", "quantity", "amount"))
  expect_named(stores, c("store_id", "city", "region", "manager"))
  expect_named(products, c("product_id", "category", "list_price"))
  expect_named(employees, c("employee_id", "store_id", "hire_date", "termination_date"))
  expect_named(marketing, c("campaign_id", "region", "start_date", "end_date", "budget"))
  expect_named(competitors, c("region", "competitor", "opening_date"))
})

test_that("Case 1 relational keys are internally consistent", {
  expect_true(all(sales$store_id %in% stores$store_id))
  expect_true(all(sales$product_id %in% products$product_id))
  expect_true(all(employees$store_id %in% stores$store_id))
  expect_true(all(marketing$region %in% stores$region))
  expect_true(all(competitors$region %in% stores$region))
})

test_that("Case 1 mystery signals match the intended story", {
  sales_by_region <- merge(sales, stores, by = "store_id")
  sales_by_region$period <- ifelse(
    sales_by_region$date < as.Date("2025-07-01"),
    "before",
    "after"
  )

  monthly_sales <- aggregate(
    amount ~ region + date + period,
    data = sales_by_region,
    FUN = sum
  )
  period_sales <- aggregate(
    amount ~ region + period,
    data = monthly_sales,
    FUN = mean
  )
  wide_sales <- reshape(
    period_sales,
    idvar = "region",
    timevar = "period",
    direction = "wide"
  )
  wide_sales$after_before_ratio <- wide_sales$amount.after / wide_sales$amount.before

  south_ratio <- wide_sales$after_before_ratio[wide_sales$region == "South"]
  other_ratios <- wide_sales$after_before_ratio[wide_sales$region != "South"]

  expect_lt(south_ratio, 0.8)
  expect_true(all(other_ratios > 1))

  priced_sales <- merge(sales_by_region, products, by = "product_id")
  priced_sales$unit_price <- priced_sales$amount / priced_sales$quantity
  priced_sales$year_month <- format(priced_sales$date, "%Y-%m")
  prices <- aggregate(
    unit_price ~ region + year_month,
    data = priced_sales[priced_sales$year_month %in% c("2025-03", "2025-04"), ],
    FUN = mean
  )
  prices_wide <- reshape(
    prices,
    idvar = "region",
    timevar = "year_month",
    direction = "wide"
  )

  expect_true(all(prices_wide[["unit_price.2025-04"]] > prices_wide[["unit_price.2025-03"]]))
  expect_equal(
    max(prices_wide[["unit_price.2025-04"]]) - min(prices_wide[["unit_price.2025-04"]]),
    0,
    tolerance = 0.01
  )

  south_marketing_2025 <- marketing[
    marketing$region == "South" & marketing$start_date >= as.Date("2025-01-01"),
  ]
  expect_true(all(diff(south_marketing_2025$budget) > 0))

  departures <- merge(employees, stores, by = "store_id")
  south_departures_before_drop <- departures[
    departures$region == "South" &
      !is.na(departures$termination_date) &
      departures$termination_date >= as.Date("2025-04-01") &
      departures$termination_date < as.Date("2025-07-01"),
  ]
  expect_gte(nrow(south_departures_before_drop), 5)

  expect_equal(
    competitors$opening_date[competitors$region == "South"],
    as.Date("2025-06-01")
  )
  expect_lt(
    competitors$opening_date[competitors$region == "South"],
    as.Date("2025-07-01")
  )
})
