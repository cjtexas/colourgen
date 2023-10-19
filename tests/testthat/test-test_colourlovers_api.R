context("test_colourlovers_api")

test_that("colour lovers api works", {
  expect_contains(
    colourgen::make_palette(colour = 1696148, n = 7),
    c("#280904", "#520C24", "#78102B", "#9A151A", "#B41914", "#D52A19", "#FC4B2A"))
})
