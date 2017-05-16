library(shiny)
library(ggplot2)
#source("twitter.r")
library(ggfittext)
library(treemapify)
library(gapminder)
library(gganimate)
theme_set(theme_bw())

shinyServer(function(input, output, session) {
  observe({
    season <- get_season(input$season)
    season_series <- all_series[all_series$Season == season, ]
    updateSelectInput(session, "series_name", 
                      choices = season_series$Show
    )
  })
  output$episode_plot <- renderPlot({
    
    season <- get_season(input$season)
    # getSeriesTweets("Arrow", season)
    specific_series <- all_series[all_series$Show == input$series_name & all_series$Season == season, ][, 3:26]
    one_series_episode <- data.frame()
    for(i in 1:24){
      one_series_episode <- rbind(one_series_episode, data.frame(Episode = paste("E", i, sep = ""), Value = as.double(as.character(specific_series[1, i]))))
    }
    
    ggplot(one_series_episode, aes(y=Value, x=Episode, group=1)) + 
      geom_line(color = "brown") + 
      geom_point(size=3) + 
      labs(x="Episode", y="Viewer Rate") + 
      ggtitle("Rating by Episode")+
      theme(plot.title = element_text(size = 20, face = "bold", hjust = 0.5, color="brown"))
  })
  
  output$plot2 <- renderPlot({
    season <- get_season(input$season)
    one_season_series <- all_series[all_series$Season == season, ]
    one_season_series[, 'AveragePerEpisode'] <- as.numeric(as.character(one_season_series[, 'AveragePerEpisode']))
    avr_network <- aggregate(AveragePerEpisode ~ Network, data = one_season_series, FUN=mean)
    blank_theme <- theme_minimal()+
      theme(
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        panel.border = element_blank(),
        panel.grid=element_blank(),
        axis.ticks = element_blank(),
        plot.title=element_text(size=14, face="bold")
      )
    
    pie <- ggplot(avr_network, aes(x="", y=AveragePerEpisode, fill=Network))+
      geom_bar(width = 1, stat = "identity") +
      coord_polar("y", start=0)
    
    pie + blank_theme +
      theme(axis.text.x=element_blank())+
      geom_text(aes(y = AveragePerEpisode/3 + c(0, cumsum(AveragePerEpisode)[-length(AveragePerEpisode)]), 
                    label = AveragePerEpisode), size=5)
    
    
  })
  
  output$tree_map <- renderPlot({
    
    first[, 'AveragePerEpisode'] <- as.numeric(as.character(first[, 'AveragePerEpisode']))
    first[, 'Show'] <- as.character(first[, 'Show'])
    first[, 'Network'] <- as.character(first[, 'Network'])
    first[, 'Loss_Gain'] <-as.numeric(as.character(first[, 'Loss_Gain']))
    first[, 'Drop'] <-as.numeric(as.character(first[, 'Drop']))
    
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
    
  })
  output$introduction({
    all_series[, 'AveragePerEpisode'] <- as.numeric(as.character(all_series[, 'AveragePerEpisode']))
    all_series[, 'Show'] <- as.character(all_series[, 'Show'])
    all_series[, 'Network'] <- as.character(all_series[, 'Network'])
    all_series[, 'Loss_Gain'] <-as.numeric(as.character(all_series[, 'Loss_Gain']))
    all_series[, 'Drop'] <-as.numeric(as.character(all_series[, 'Drop']))
    all_series[, 'Season'] <-as.character(all_series[, 'Season'])
    
    p <- ggplot(all_series, aes(Drop, AveragePerEpisode, size = Loss_Gain, color = Network, frame = Season )) +
      geom_point() +
      ggtitle("Animation by Season")+
      labs(x="Drop Rate", y="Average of Episodes")
    scale_x_log10()
    
    gganimate(p, interval = 1)
  })
})