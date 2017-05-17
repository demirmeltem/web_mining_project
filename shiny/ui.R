library(shiny)

shinyUI(fluidPage(
  
  navbarPage("Menu",
             tabPanel("General",
                      fixedRow(
                        column(9,
                               tags$h2("Top TV Series Ratings"),
                               fixedRow(
                                 column(9,
                                        tags$br(),
                                        "Hey!  We have built a beautiful, hand-crafted website with shiny framework. This website is to show you ratings of the series with various graphs. You can also see drop, loss/gain, average of views, episode of views and channels. We fecthed the data from rating website which is http://www.spoilertv.com . We did it for you. I hope, you enjoy it!",
                                        tags$br(),
                                        tags$img(height = 352, width = 352, src="http://orig14.deviantart.net/7d96/f/2013/287/d/3/tv_series_icon_by_quaffleeye-d6qj64q.png")
                                        ),
                                 column(3,
                                        imageOutput("animation")
                                 )
                               )
                        )
                      )
                      
                      
                       
                      
                      
                      
             ),
             tabPanel("Viewers Rate",
                      sidebarLayout(position= "right",
                                    sidebarPanel(
                                      selectInput("season", "Season",
                                                  choices = seasons,
                                                  selected = ""),
                                      selectInput("series_name", "Series",
                                                  choices = season_series)
                                    ),
                                    mainPanel(
                                      plotOutput("episode_plot", height = 500)
                                    ))
             ),
             tabPanel("Word Cloud", 
                      sidebarLayout(position= "right",
                        # Sidebar with a slider and selection inputs
                        sidebarPanel(
                          selectInput("selection", "Choose a series",
                                      choices = (all_series$Show)),
                          actionButton("update", "Change"),
                          hr(),
                          sliderInput("freq",
                                      "Minimum Frequency:",
                                      min = 1,  max = 50, value = 1),
                          sliderInput("max",
                                      "Maximum Number of Words:",
                                      min = 1,  max = 300,  value = 300)
                        ),
                        
                        # Show Word Cloud
                        mainPanel(
                          plotOutput("word_cloud_plot", height = 550)
                        )
                      )
                      
                      
                      
                  
             ),
             tabPanel("By Season",
                      sidebarLayout(position= "right",
                                    sidebarPanel(
                                      selectInput("tree_map_season", "Season",
                                                  choices = seasons,
                                                  selected = "")
                                    ),
                                    mainPanel(
                                      tabsetPanel(
                                        tabPanel("Average Views", 
                                                 plotOutput("avg_views_plot", height = 500)
                                                 ),
                                        tabPanel("TV Series by Channel", 
                                                 plotOutput("tree_map_plot", height = 500)
                                                 )
                                      )
                                    ))

             )
  )
  
  
  
  
  
))