context("test_colourlovers_api")

test_that("colour lovers api works", {
  expect_equal(colourgen::make_palette(colour = 99, n = 7)$palette,
               c("#FFFFCC", "#FF7FCC", "#FF00CC", "#984CE5", "#3399FF", "#194C7F", "#000000"))
})
