#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
#
library(tidyverse)
library(readr)
library(shiny)
library(shinydashboard)
library(leaflet)
library(shinyWidgets)
library(shinythemes)
library(DT)
library(tools)


data15 <- readRDS("all_CT_and_weather_SH_join.RDS")
datacal <- readRDS("Total_DH_and_yield.RDS")
datadaily <- readRDS("daily_stress.RDS")

ui <- dashboardPage(
  dashboardHeader(title = "Shiny Biotic"), 
    dashboardSidebar(
      
      #load menu items
      sidebarMenu(
        menuItem("Landing", tabName = "Landing", icon = icon("paper-plane")),
        menuItem("15min", tabName = "rows", icon = icon("dashboard")),
        menuItem("summ_daily", tabName = "second", icon = icon("th")),
        menuItem("summ_yield", tabName = "yield", icon = icon("chart-bar"))
      )
    ),
  dashboardBody(
    #load tab items frmo the menuitem
    (tabItems(tabItem(tabName  = "Landing",
                      h2("Select 15 minute Data to View"),
      fluidRow(
                column(4,
                               
                         # Copy the line below to make a slider bar 
                               sliderInput("slider1", label = h3("Slider"), min = 0, 
                                 max = 100, value = 50)
                        ),
                        column(4,
                               
                               # Copy the line below to make a slider range 
                          sliderInput("slider2", label = h3("Slider Range"), min = 0, 
                                     max = 100, value = c(40, 60))
                        )
                      ),
                      
                      hr(),
                      
                      fluidRow(
                        column(4, verbatimTextOutput("value")),
                        column(4, verbatimTextOutput("range"))
                      )
    )                 
    )
    ),
    
    tabItem(tabName = "rows",
            h2("select rows")
    )
    )
    )
  


      
      # Boxes need to be put in a row (or column)
      fluidRow(
       column(width = 12,
               h2("Please select data source")
              ),
      
        #box(width =8,plotOutput("plot1", height = 250)),
        
      #  box(
       #   width = 4,
        #  title = "Controls",
         # sliderInput("slider", "Number of observations:", 1, 100, 50)
        #)
    #  )
    )
  
  
  server <- function(input, output) {
    set.seed(122)
    histdata <- rnorm(500)
    
    output$plot1 <- renderPlot({
      data <- histdata[seq_len(input$slider)]
      hist(data)
    })
    
    # You can access the value of the widget with input$slider1, e.g.
    output$value <- renderPrint({ input$slider1 })
    
    # You can access the values of the second widget with input$slider2, e.g.
    output$range <- renderPrint({ input$slider2 })
    
    
  }
  
  shinyApp(ui, server)