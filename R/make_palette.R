#' make_palette
#'
#' @description This function will generate colour palettes of arbitrary size
#' from an R base graphics color function, ColorBrewer named palette, 
#' COLOURLovers pallete ID or vector of named or hex colours.
#' Defaults to a nice Tableau-esque Orange->Blue divering or 
#' Stephen Few-esque Earth->Emerald...
#'
#' @param colour colour(s) to be turned into a palette
#' @param n numeric the number of colours to be returned
#' @param reverse logical should the return palette order be reversed?
#' @param shuffle logical should the return palette be shuffled?
#' @param default logical should default palette be Tableau-esque orange-blue diverging?
#'
#' @return list object containing palette and plot
#' 
#' @importFrom jsonlite fromJSON
#'
#' @examples 
#' 
#' ### Brewer Colour Palette 
#' colourgen(colour = 'Spectral')
#'
#' ### COLOURlovers ID
#' make_palette(colour = 3914747)
#' make_palette(colour = 987654)
#' 
#' ### Custom Colour Vector
#' my_colours <- c("#CAF60D", "#18D33A", "#4255EC", "#E60873", "#19312A")
#' make_palette(colour = my_colours)
#' 
#' ### Default Behaviour
#' make_palette(default = TRUE)
#' make_palette(default = FALSE)
#' 
#' @export
#'
make_palette <- function(colour=NULL, n=7, reverse=FALSE, shuffle=FALSE, default=TRUE) {
  
  brewer_list <- jsonlite::fromJSON(system.file("json/brewerList.json", package = "colourgen"))
  brewer_names <- names(brewer_list)
  
  if (length(colour)>1) {
    colour_fun <- tryCatch({
      colorRampPalette(colour)
    }, error = function(e) {
      default_pal(default)
    })
  }
  
  if (!is.null(colour) && colour %in% c("rainbow", "heat.colors", "terrain.colors", "topo.colors", "cm.colors", "gray.colors")) {
    colour_fun <- eval(parse(text = colour))
  }
  
  if (!is.null(colour) && colour %in% c("viridis", "magma", "plasma", "inferno")) {
    if (suppressWarnings(require("viridisLite"))) {
      colour_fun <- eval(parse(text = colour))
    } else {
      colour_fun <- default_pal(default)
    }
  }
  
  if (!is.null(colour) && tolower(colour) %in% tolower(brewer_names)) {
    column_match <- which(tolower(brewer_names) %in% tolower(colour))
    colour_fun <- colorRampPalette(brewer_list[[column_match]])
  } 

  if (is.numeric(colour)) {
    colour_fun <- tryCatch({
      # try colourlovers API with user supplied palette ID
      res <- jsonlite::fromJSON(sprintf("http://www.colourlovers.com/api/palette/%s?format=json", colour[1]))
      col_vec <- unlist(res$colors)
      col_vec <- paste0('#', col_vec)
      colorRampPalette(col_vec)
    }, error = function(e) {
      default_pal(default)
    })
  }

  if (!exists("colour_fun")) {
    colour_fun <- default_pal(default)
    colour_string <- colour_fun(n)
  } else {
    colour_string <- colour_fun(n)
  }
  
  if (reverse) {
    colour_string <- rev(colour_fun(n))
  }
  
  if (shuffle) {
    set.seed(333)
    colour_string <- sample(colour_fun(n))
  }
  
  output <- list()
  # set plot background to neutral grey
  par(bg = "#BFBFBF")
  par(mar=c(7,2,2,2))
  
  barplot(height = rep(1, n), col = colour_string, yaxt = 'n', 
          names.arg = colour_string, las = 2, border = NA, space = 0)
  output$plot <- recordPlot()
  # set plot backround back to normal white
  par(bg = "#FFFFFF")
  output$palette <- colour_string
  
  return(output)
  
}
