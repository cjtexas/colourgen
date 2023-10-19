context("test_basics")

test_that("default functionality works", {
  expect_contains(
    colourgen::make_palette(),
    c("#7B3014", "#D04A07", "#F98C40", "#C8C9CA", "#5AA5CD", "#236CA7", "#26456E"))
})


test_that("unknown colour is handled", {
  expect_contains(
    colourgen::make_palette(colour = "blah"),
    c("#7B3014", "#D04A07", "#F98C40", "#C8C9CA", "#5AA5CD", "#236CA7", "#26456E"))
})
