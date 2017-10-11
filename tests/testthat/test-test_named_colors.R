context("test_named_colors")

test_that("named colors work", {
  expect_equal(colourgen::make_palette(colour = c("red", "yellow", "darkgreen"), n = 7)$palette,
               c("#FF0000", "#FF5500", "#FFAA00", "#FFFF00", "#AACB00", "#559700", "#006400"))
})

test_that("brewer palettes work", {
  expect_equal(colourgen::make_palette(colour = "Purples", n = 7)$palette,
               c("#FCFBFD", "#E8E6F1", "#C6C6E1", "#9E9AC8", "#786EB2", "#5B3595", "#3F007D"))
})
