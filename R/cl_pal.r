#' cl_pal
#' 
#' @param colour int colourlovers palette id
#' 
#' @import httr
#' 
cl_pal <- function(colour) {
  
  url <- sprintf("https://www.colourlovers.com/api/palette/%s", colour[1])
  
  res <- httr::GET(
    url,
    httr::add_headers(
      Connection = "keep-alive",
      "Cache-Control" = "max-age=0",
      DNT = "1",
      "User-Agent" = "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/117.0",
      "Accept-Language" = "en-US,en;q=0.9,da;q=0.8,sv;q=0.7"
    )
  )
  
  res <- readLines(textConnection(content(res, "text")))
  res <- res[which(grepl("<hex>(.*?)</hex>", res))]
  col_vec <- sub("\\t\t\t<hex>(.*?)</hex>",  "\\1", res)
  col_vec <- paste0('#', col_vec)
  
  colour_fun <- colorRampPalette(col_vec)
  
  return(colour_fun)

}
