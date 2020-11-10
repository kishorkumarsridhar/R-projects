# A vector containing the primary and secondary DOT colors

dot_colors <- c(
  `brown`       = "#7C2529",
  `light grey` = "#B1B3B3",
  `dark grey`  = "#53565A",
  `sea blue`  = "#0097A9",
  `orange`       = "#E87722",
  `yellow`     = "#FFC72C",
  `purple`     = "#5E366E",
  `green`     = "#719949",
  `blue`     = "#4698CB"
)

# Creating a function to access the colors

dot_cols <- function(a) {
  dot_colors[a]
}

# creating a DOT themed color palatte

dot_palettes <- list(
  `primary`  = dot_cols(c("brown", "light grey", "dark grey")),

  `secondary`  = dot_cols(c("sea blue", "orange", "yellow", "purple", "green", "blue")))

# Creating a function to access the color palatte

dot_pal <- function(palette = "main", reverse = FALSE) {
  pal <- dot_palettes[[palette]]

  if (reverse) pal <- rev(pal)

  colorRampPalette(pal)
}

# creating a custom color brewers for DOT color palatte

#' Function to access the custom color brewers of primary and secondary color palettes of DOT
#'
#' This function takes two arguments namely "palette" and "reverse". Accesses the custom color palette with the combination of primary and secondary colors of DOT. Used in conjunction with ggplot. Used for plots to color "points" in a chart. Eg. scatterplots, residual plots etc
#' @param palette Takes the values "primary" or "secondary" to access the combination of primary and secondary colors of DOT respectively
#' @param discrete Always set to the default value to be TRUE. Denotes that Discrete values are supplied to discrete scale. If changed to FALSE, errors out with the message "Discrete value supplied to continuous scale"
#' @param reverse Default value is False. If set to TRUE, reverses the color palette used
#' @export

scale_color_dot <- function(palette = "main", discrete = TRUE, reverse = FALSE) {
  pal <- dot_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("colour", paste0("dOT_", palette), palette = pal)
  } else {
    scale_color_gradientn(colours = pal(256))
  }
}


#' Function to access the custom fill brewers of primary and secondary color palettes of DOT
#'
#' This function takes two arguments namely "palette" and "reverse". Accesses the custom color palette with the combination of primary and secondary colors of DOT. Used in conjunction with ggplot. Used for plots to color "bars" in a chart. Eg. Histograms, barcharts etc
#' @param palette Takes the values "primary" or "secondary" to access the combination of primary and secondary colors of DOT respectively
#' @param discrete Always set to the default value to be TRUE. Denotes that Discrete values are supplied to discrete scale. If changed to FALSE, errors out with the message "Discrete value supplied to continuous scale"
#' @param reverse Default value is False. If set to TRUE, reverses the color palette used
#' @export

scale_fill_dot <- function(palette = "main", discrete = TRUE, reverse = FALSE) {
  pal <- dot_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("fill", paste0("dOT_", palette), palette = pal)
  } else {
    scale_fill_gradientn(colours = pal(256))
  }
}

