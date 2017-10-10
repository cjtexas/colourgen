context("test_grdevice_functions")

test_that("gr device functions work", {
  expect_equal(colourgen::make_palette("cm.colors", n = 4)$palette, c("#80FFFFFF", "#BFFFFFFF", "#FFBFFFFF", "#FF80FFFF"))
})
