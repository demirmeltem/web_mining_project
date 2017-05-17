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
                                    sidebarPanel(
                                      selectInput("series_name", "Series",
                                                  choices = all_series)
                                    ),
                                    mainPanel(
                                      plotOutput("word_cloud")
                                    ))
             ),
             tabPanel("TreeMap",
                      sidebarLayout(position= "right",
                                    sidebarPanel(
                                      selectInput("tree_map_season", "Season",
                                                  choices = seasons,
                                                  selected = "")
                                    ),
                                    mainPanel(
                                      plotOutput("tree_map_plot")
                                    ))
             )
  )
  
  
  
  
  
))