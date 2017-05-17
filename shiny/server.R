library(shiny)
library(ggplot2)
#source("twitter.r")
library(ggfittext)
library(treemapify)
library(gapminder)
library(gganimate)
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
      geom_line(color = "#5170a0", size=1) + 
      geom_point(size=2.2) + 
      labs(x="\nEpisode", y="Viewer Rate(x10000)\n") + 
      theme(axis.title = element_text(size=14, family = "URWTimes")) +
      
      theme(axis.text.x = element_text(size = 10, color="brown")) +
      theme(axis.text.y = element_text(size = 10, color="brown")) +
      ggtitle("Viewers Rate by Episode")+
      theme(plot.title = element_text(size = 24, face = "bold", family="URWTimes", hjust = 0.5, color="#89b2f4"))
  })
  
  output$pie_plot <- renderPlot({
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
  
  output$tree_map_plot <- renderPlot({
    season <- get_season(input$tree_map_season)
    season_series <- all_series[all_series$Season == season, ]
    
    treeMapCoordinates <- treemapify(season_series,
                                     area = "AveragePerEpisode",
                                     fill = "Network",
                                     label = "Show",
                                     group = "Network",
                        
    )
    treeMapPlot <- ggplotify(treeMapCoordinates) +
      scale_x_continuous(expand = c(0, 0)) +
      scale_y_continuous(expand = c(0, 0)) +
      scale_fill_brewer(palette = "Set2")
    
    treeMapPlot
    
  })
  
  # word cloud
  terms <- reactive({
    # Change when the "update" button is pressed...
    input$update
    # ...but not for anything else
    isolate({
      withProgress({
        setProgress(message = "Processing corpus...")
        getTermMatrix(input$selection)
      })
    })
  })
  
  # Make the wordcloud drawing predictable during a session
  wordcloud_rep <- repeatable(wordcloud)
  
  
  output$word_cloud_plot <- renderPlot({
    v <- terms()
    wordcloud_rep(names(v), v, scale=c(5, .5), random.order=FALSE,
                  min.freq = input$freq, max.words=input$max,
                  colors = brewer.pal(4, "Dark2"))
  })
})