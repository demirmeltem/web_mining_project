
radius <- sqrt( ten_series$AveragePerEpisode/ pi )
symbols(ten_series$Loss_Gain, ten_series$Drop, circles=radius, 
        inches=0.35, fg="white", bg="pink", xlab="Loss/Gain", ylab="Drop")
text(ten_series$Loss_Gain, ten_series$Drop, ten_series$Show, cex=0.5)

#ggplot bubble chart 

ten_series[, 'Show'] <- as.character(ten_series[, 'Show'])
ten_series[, 'Network'] <- as.character(ten_series[, 'Network'])
ten_series[, 'Loss_Gain'] <-as.numeric(as.character(ten_series[, 'Loss_Gain']))
ten_series[, 'Drop'] <-as.numeric(as.character(ten_series[, 'Drop']))
ten_series[, 'AveragePerEpisode'] <-as.numeric(as.character(ten_series[, 'AveragePerEpisode']))

options(scipen = 999)
library(ggplot2)
library(ggalt)
series <- ten_series[ten_series$AveragePerEpisode > 2.82 & 
                       ten_series$AveragePerEpisode <= 4.66 & 
                       ten_series$Loss_Gain > -1.52 & 
                       ten_series$Loss_Gain < 1.42, ]

# Plot
ggplot(ten_series, aes(x=AveragePerEpisode, y=Loss_Gain)) + 
  geom_point(aes(col=Network, size=AveragePerEpisode)) +   # draw points
  geom_smooth(method="loess", se=F) + 
  xlim(c(0, 0.1)) + 
  ylim(c(0, 500000)) +   # draw smoothing line
  geom_encircle(aes(x=AveragePerEpisode, y=Loss_Gain), 
                data=ten_series, 
                color="red", 
                size=2, 
                expand=0.08) +   # encircle
  labs(subtitle="Average vs Loss_Gain", 
       y="Loss Gain", 
       x="Average", 
       title="Scatterplot + Encircle", 
       caption="Source: ten_series")

#another

library(ggplot2)

#bubble_chart <- ten_series[ten_series$AveragePerEpisode %in% ten_series$Network, ]
# Scatterplot
theme_set(theme_bw())  # pre-set the bw theme.
g <- ggplot(ten_series, aes(Loss_Gain, Drop, label = Show)) + 
  labs(subtitle="mpg: Loss-Gain vs Drop",
       title="Bubble chart")

g + geom_jitter(aes(col=Network, size=AveragePerEpisode)) + 
  geom_smooth(aes(col=Network), method="lm", se=F) +
  geom_text(check_overlap = TRUE)

#animasyonlu bubble chart by seasons

library(ggplot2)
library(gganimate)
library(gapminder)
theme_set(theme_bw())  # pre-set the bw theme.

g <- ggplot(all_series, aes(Loss_Gain, Drop, size = AveragePerEpisode, frame = Season)) +
  geom_point() +
  geom_smooth(aes(group = Season), 
              method = "lm", 
              show.legend = FALSE) +
  facet_wrap(~Network, scales = "free") +
  scale_x_log10()  # convert to log scale

gganimate(g, interval=0.2)




# site: https://cran.r-project.org/web/packages/googleVis/vignettes/googleVis_examples.html , http://tutorials.iq.harvard.edu/R/Rgraphics/Rgraphics.html#org7628198