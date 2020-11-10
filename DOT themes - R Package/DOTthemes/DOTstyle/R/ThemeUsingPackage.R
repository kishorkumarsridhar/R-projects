install.packages("ggplot2")
library(ggplot2)
install.packages("ggthemes")
library(ggthemes)
install.packages("extrafont")
library(extrafont)
install.packages("DOTstyle")
library("DOTstyle")

windowsFonts(`Eurostar` = windowsFont("Eurostar"))
#windowsFonts(`Eurostar` = windowsFont("Eurostar Regular"))
windowsFonts(`PT Sans` = windowsFont("PT Sans"))
windowsFonts(`Arial` = windowsFont("Arial"))

install.packages("\\\ntdfs\\(W)DataStor\\PerformanceTechnology\\AssetMgmt\\ggplot2 themes for DOT\\DOTthemes\\DOTstyle_0.1.0.tar.gz")

g <- ggplot(mpg, aes(displ)) + scale_fill_dot(discrete = TRUE, palette = "secondary", reverse = TRUE)

g <- g + geom_histogram(aes(fill=class), 
                        binwidth = .1, 
                        col="black", 
                        size=.1) + 
  labs(title = 'Iowa DOT',
       subtitle = 'DOT graphs',
       x = 'x-axis',
       y = 'y-axis',
       caption = 'dot.iowa.gov') +
  theme_dot()
g


p <- ggplot(iris, aes(Sepal.Width, Sepal.Length, color = Species)) +
  geom_point(size = 4) +
  scale_color_dot(discrete = TRUE, palette = "secondary", reverse = TRUE)+ labs(title = 'Iowa DOT theme',
                                                                subtitle = 'DOT graphs',
                                                                x = 'x-axis',
                                                                y = 'y-axis',
                                                                caption = 'iowadot.us')+
  theme_dot()
p


stbar <- ggplot(diamonds, aes(cut, fill = color)) +
  geom_bar() +
  scale_fill_dot(discrete = TRUE, palette = "primary") +
  labs(title = 'Iowa DOT theme',
       subtitle = 'DOT graphs',
       x = 'x-axis',
       y = 'y-axis',
       caption = 'iowadot.us') +
  theme_dot()
stbar

