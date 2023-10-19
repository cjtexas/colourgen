context("test_grdevice_functions")

test_that("gr device functions work", {
  expect_contains(
    colourgen::make_palette("cm.colors", n = 4), 
    c("#80FFFF", "#BFFFFF", "#FFBFFF", "#FF80FF"))
})
