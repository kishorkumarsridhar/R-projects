# Internal function that installs the required DOT fonts prior to making the ggplots

DOTfonts <- function(){
  windowsFonts(`Eurostar` = windowsFont("Eurostar"))
  windowsFonts(`Eurostar Regular` = windowsFont("Eurostar Regular"))
  windowsFonts(`PT Sans` = windowsFont("PT Sans"))
  windowsFonts(`Arial` = windowsFont("Arial"))
}
