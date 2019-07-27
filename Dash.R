#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readr)
library(shiny)
library(shinydashboard)
library(leaflet)
library(shinyWidgets)
library(shinythemes)
library(DT)
library(tools)
library(tidyverse)

#data15 <- readRDS("all_CT_and_weather_SH_join.RDS")
datacal <- readRDS("Total_DH_and_yield.RDS")
datadaily <- readRDS("daily_stress.RDS")

ui <- dashboardPage(
  dashboardHeader(title = "Shiny Biotic"), 
    dashboardSidebar(),
    dashboardBody(
      # Boxes need to be put in a row (or column)
      fluidRow(
        column(width = 12,
               h2("Please select data source")
               ),
      
        box(width =8,plotOutput("plot1", height = 250)),
        
        box(
          width = 4,
          title = "Controls",
          sliderInput("slider", "Number of observations:", 1, 100, 50)
        )
      )
    )
  )
  
  server <- function(input, output) {
    set.seed(122)
    histdata <- rnorm(500)
    
    output$plot1 <- renderPlot({
      data <- histdata[seq_len(input$slider)]
      hist(data)
    })
  }
  
  shinyApp(ui, server)