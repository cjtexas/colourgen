#' default_pal
#' 
default_pal <- function(default) {
  invalid_color_warning <- ifelse(default, 
                                  "Empty or Unknown Colour(s)... \n  Defaulting to Tableau-esque \n  Orange-Blue Diverging Palette",
                                  "Empty or Unknown Colour(s)... \n  Defaulting to Stephen Few-esque \n  Earth-Emerald Diverging Palette")
  message(invalid_color_warning)
  
  if (default) {
    tableau_palette <- c('#7B3014', '#C03C01', '#F16815', 
                         '#FD9E56', '#C8C9CA', '#6FB7D9', 
                         '#3282B5', '#1C61A0', '#26456E')
    colour_fun <- colorRampPalette(tableau_palette)
  } else {
    few_palette <- c('#3E2B09', '#5D410F', '#906E32', 
                     '#B5A668', '#C8C9CA', '#6DC99F', 
                     '#55B89C', '#40907F', '#1C5C4E')
    colour_fun <- colorRampPalette(few_palette)
  }
  return(colour_fun)
}
