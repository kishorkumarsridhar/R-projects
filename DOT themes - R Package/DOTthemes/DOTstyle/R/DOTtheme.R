#' Function to use DOT custom theme
#'
#' Uses the theme_classic() as the default theme.
#' The Title font is Eurostar.
#' The Subtitle font is PT Sans.
#' The Caption (at the bottom) font is Arial.
#' @param No parameters are required
#' @export


theme_dot <- function(){
  theme_classic() +
    theme(plot.title = element_text(color = '#7C2529', family = "Eurostar", face = 'bold'),
          plot.subtitle = element_text(color = '#53565A', family = "PT Sans", face = 'bold'),
          plot.caption = element_text(color = '#53565A',family = "Arial", face = 'bold'),
          plot.background = element_rect(colour = "#B1B3B3"))
}
