library(shiny)

shinyUI(fluidPage(
  
  navbarPage("Menu",
             tabPanel("General",
                      mainPanel(
                        plotOutput("plot2")
                      )
             ),
             tabPanel("Viewer Rate",
                      sidebarLayout(position= "right",
                                    sidebarPanel(
                                      selectInput("season", "Season",
                                                  choices = seasons,
                                                  selected = ""),
                                      selectInput("series_name", "Series",
                                                  choices = season_series)
                                    ),
                                    mainPanel(
                                      plotOutput("episode_plot")
                                    ))
             ),
             tabPanel("Word Cloud", 
                      sidebarLayout(position= "right",
                        # Sidebar with a slider and selection inputs
                        sidebarPanel(
                          selectInput("selection", "Choose a series",
                                      choices = all_series),
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
                          plotOutput("word_cloud_plot")
                        )
                      )
                      
                      
                      
                  
             ),
             tabPanel("TreeMap",
                      sidebarLayout(position= "right",
                                    sidebarPanel(
                                      selectInput("season", "Season",
                                                  choices = seasons,
                                                  selected = "")
                                    ),
                                    mainPanel(
                                      plotOutput("tree_map")
                                    ))
             )
  )
  
  
  
  
  
))