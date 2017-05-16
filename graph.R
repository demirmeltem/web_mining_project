
ggplot(first, aes(y=Show, x=AveragePerEpisode)) + geom_point()

p1 <- ggplot(first, aes(x = AveragePerEpisode, y = Network))
      + geom_text(aes(label=State), size = 3)

#pie char for networks

lbls <- avr_network$Network
pct <- round(avr_network$AveragePerEpisode/sum(avr_network$AveragePerEpisode)*100)
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(avr_network$AveragePerEpisode,labels = lbls, col=rainbow(length(lbls)),
    main="Pie Chart of Networks by Seasons")

library(googleVis)
Pie <- gvisPieChart(avr_network, options=list(width="450px", height="450px"))
plot(Pie)

#First Ten Series rating plot


p1 <- ggplot(ten_series, aes(y=AveragePerEpisode, x=Show)) + geom_point()
p1

#deneme
library(googleVis)


Line <- gvisLineChart(ten_series)
plot(Line)

#Loss_Gain, Drop, AveragePerEpisode
Column <- gvisColumnChart(ten_series)
plot(Column)


#bubble chart with googleVis

Bubble <- gvisBubbleChart( ten_series, idvar = "Show", 
                           xvar="Drop", yvar="AveragePerEpisode",
                           colorvar="Network", sizevar="Loss_Gain",
                           options=list(
                             hAxis='{minValue:50, maxValue:100}'))

plot(Bubble)

