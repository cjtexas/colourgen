#' ch_pal
#' 
#' @param colour int color-hex.com palette id
#' 
#' @import httr
#' 
ch_pal <- function(colour) {
  
  url <- sprintf("https://www.color-hex.com/color-palette/%s", colour[1])
  
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
  res <- res[which(grepl("palettecolordivc", res))]
  col_vec <- sub('.*title="#([a-fA-F0-9]{6})".*', '#\\1', res[grep('title="#[a-fA-F0-9]{6}"', res)])
  
  colour_fun <- colorRampPalette(col_vec)
  
  return(colour_fun)

}
