#' image_pal
#' 
#' Read an image from disk or url and extract dominant colors using kmeans.
#' 
#' @param image_source character file path or url
#' @param n integer number of color centers to extract
#' 
#' @import jpeg png reshape2
#' 
image_pal <- function(image_source="https://www.r-project.org/Rlogo.png") {
  
  set.seed(333)
  
  if (!file.exists(image_source)) {
    image_file <- tempfile()
    suppressWarnings(download.file(image_source, image_file, mode = "wb", extra = "-t 1", quiet = T))
    if (grepl("png", tolower(tools::file_ext(image_source)))) {
      img <- png::readPNG(image_file)
    } else {
      img <- jpeg::readJPEG(image_file)
    }
  } else {
    if (grepl("png", tolower(tools::file_ext(image_source)))) {
      img <- png::readPNG(image_source)
    } else {
      img <- jpeg::readJPEG(image_source)
    }
  }
  
  # resize the image to 200x200 using sampling
  min_sample_vec <- min(dim(img)[1], dim(img)[2])
  subset_vec <- sample(1:min_sample_vec, min(min_sample_vec, 200))
  img <- img[subset_vec, subset_vec, ]
  
  long_img <- reshape2::melt(img)
  rgb_image <- reshape(long_img, timevar = "Var3",
                      idvar = c("Var1", "Var2"), direction = "wide")
  rgb_image$Var1 <- -rgb_image$Var1
  
  col_kmeans <- suppressWarnings(kmeans(rgb_image[, 3:5], centers = 9, nstart = 4, iter.max = 100))

  colours <- sort(rgb(col_kmeans$centers))
  colour_fun <- colorRampPalette(colours)

  return(colour_fun)
  
  }