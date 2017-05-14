library(shiny)

shinyUI(fluidPage(
  titlePanel("Web Mining Project"),
  
  sidebarLayout(position= "right",
                sidebarPanel("sidebar panel"),
                mainPanel("main panel",
                          h1("First", align="center"),
                          h2("Second"),
                          h3("Third"))
                )
  
 
))