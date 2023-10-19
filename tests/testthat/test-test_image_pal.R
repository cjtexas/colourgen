context("test_image_pal")

test_that("url image is handled", {
  expect_contains(
    colourgen::make_palette(colour = "https://www.r-project.org/Rlogo.png"),
    c("#000000", "#2165B9", "#6981A3", "#A5A6AB", "#B5B7BB", "#C2C4C7", "#FEFFFF"))
})
