
#Treemap
library(ggplot2)
library(ggfittext)
library(treemapify)

treeMapCoordinates <- treemapify(first,
                                 area = "AveragePerEpisode",
                                 fill = "Network",
                                 label = "Show",
                                 group = "Network"
                                 )
treeMapPlot <- ggplotify(treeMapCoordinates) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  scale_fill_brewer(palette = "Set2")

treeMapPlot


#animation

library(gapminder)
library(ggplot2)
library(gganimate)
theme_set(theme_bw())

p <- ggplot(all_series, aes(Drop, AveragePerEpisode, size = Loss_Gain, color = Network, frame = Season )) +
  geom_point() +
  ggtitle("Animation by Season")+
  labs(x="Drop Rate", y="Average of Episodes")
  scale_x_log10()

gganimate(p, interval = 1)






