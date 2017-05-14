
ggplot(first, aes(y=Show, x=AveragePerEpisode)) + geom_point()

p1 <- ggplot(first, aes(x = AveragePerEpisode, y = Network))
      + geom_text(aes(label=State), size = 3)

#pie char for networks
first <- all_series[all_series$Season == "2012_13",]
first[, 'AveragePerEpisode'] <- as.numeric(as.character(first[, 'AveragePerEpisode']))
avr_network <- aggregate(AveragePerEpisode ~ Network, data = first, FUN=mean)
lbls <- avr_network$Network
pct <- round(avr_network$AveragePerEpisode/sum(avr_network$AveragePerEpisode)*100)
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(avr_network$AveragePerEpisode,labels = lbls, col=rainbow(length(lbls)),
    main="Pie Chart of Networks")

library(googleVis)
Pie <- gvisPieChart(avr_network, options=list(width="450px", height="450px"))
plot(Pie)

#First Ten Series rating plot
ten_series <- first[1:10, ]
ten_series <- ten_series[order(ten_series$AveragePerEpisode), ]

p1 <- ggplot(ten_series, aes(y=AveragePerEpisode, x=Show)) + geom_point()
p1

#deneme
library(googleVis)
ten_series[, 'Show'] <- as.character(ten_series[, 'Show'])
ten_series[, 'Network'] <- as.character(ten_series[, 'Network'])
ten_series[, 'Loss_Gain'] <-as.numeric(as.character(ten_series[, 'Loss_Gain']))
ten_series[, 'Drop'] <-as.numeric(as.character(ten_series[, 'Drop']))

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

