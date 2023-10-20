#' make_palette
#'
#' @description This function will generate colour palettes of arbitrary size
#' from an R base graphics color function, ColorBrewer named palette, 
#' COLOURLovers pallete ID or vector of named or hex colours.
#' Also, a source image file (png or jpeg) or url can be used.
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
#' @import graphics grDevices
#'
#' @examples 
#' 
#' ### Brewer Colour Palette 
#' make_palette(colour = 'Spectral')
#'
#' ### COLOURlovers ID
#' make_palette(colour = 3914747)
#' make_palette(colour = 987654)
#' 
#' ### Custom Colour Vector
#' my_colours <- c("#CAF60D", "#18D33A", "#4255EC", "#E60873", "#19312A")
#' make_palette(colour = my_colours)
#' 
#' ### Sample Source Image
#' make_palette(colour = "https://www.r-project.org/Rlogo.png")
#' 
#' ### Default Behaviour
#' make_palette(default = TRUE)
#' make_palette(default = FALSE)
#' 
#' @export
#'
make_palette <- function(colour=NULL, n=7, reverse=FALSE, shuffle=FALSE, default=TRUE) {
  
  utils::data("brewer_list", package = "colourgen", envir = environment())
  brewer_names <- names(brewer_list)
  
  if (length(colour)>1) {
    colour_fun <- tryCatch({
      colorRampPalette(colour)
    }, error = function(e) {
      default_pal(default)
    })
  }
  
  if (!is.null(colour) && length(colour)==1 && colour %in% c("rainbow", "heat.colors", "terrain.colors", "topo.colors", "cm.colors", "gray.colors")) {
    colour_fun <- eval(parse(text = colour))
  }
  
  if (!is.null(colour) && length(colour)==1 && colour %in% c("cividis", "inferno", "magma", "mako", "plasma", "rocket", "turbo", "viridis")) {
    if (suppressWarnings(require("viridisLite"))) {
      colour_fun <- eval(parse(text = colour))
    } else {
      warning(paste("Please install the viridisLite package in order to generate a palette from the colour:", colour))
      colour_fun <- default_pal(default)
    }
  }
  
  if (!is.null(colour) && length(colour)==1 && tolower(colour) %in% tolower(brewer_names)) {
    column_match <- which(tolower(brewer_names) %in% tolower(colour))
    colour_fun <- colorRampPalette(brewer_list[[column_match]])
  } 

  if (is.numeric(colour)) {
    colour_fun <- tryCatch({
      cl_pal(colour)
    }, error = function(e) {
      default_pal(default)
    })
  }
  
  if (!exists("colour_fun")) {
    colour_fun <- tryCatch({
      image_pal(colour)
    }, error = function(e) {
      default_pal(default)
    })
  }

  if (!exists("colour_fun")) {
    colour_fun <- default_pal(default)
    colour_palette <- colour_fun(n)
  } else {
    colour_palette <- colour_fun(n)
  }
  
  if (reverse) {
    colour_palette <- rev(colour_fun(n))
  }
  
  if (shuffle) {
    set.seed(333)
    colour_palette <- sample(colour_fun(n))
  }
  
  class(colour_palette) <- c("colourgen", class(colour_palette))
  return(colour_palette)
  
}



#' @export
print.colourgen <- function(x) {
  cat(x, sep = "\n")
}



#' @export
plot.colourgen <- function(x) {
  par(bg = "#BFBFBF")
  par(mar=c(7,2,2,2))
  n <- length(x)
  barplot(height = rep(1, n), col = x, yaxt = "n", 
          names.arg = x, las = 2, border = NA, space = 0)
  par(bg = "#FFFFFF")
}
