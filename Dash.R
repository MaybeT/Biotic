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
                      h2("Select 15 minute Data to View")
    ),
    tabItem(tabName = "rows",
            h2("select rows")
    )
    )
    )
  )
)

      
      # Boxes need to be put in a row (or column)
      #fluidRow(
      # column(width = 12,
       #        h2("Please select data source")
        #      ),
      
        #box(width =8,plotOutput("plot1", height = 250)),
        
      #  box(
       #   width = 4,
        #  title = "Controls",
         # sliderInput("slider", "Number of observations:", 1, 100, 50)
        #)
    #  )
 #   )
  
  
  server <- function(input, output) {
    set.seed(122)
    histdata <- rnorm(500)
    
    output$plot1 <- renderPlot({
      data <- histdata[seq_len(input$slider)]
      hist(data)
    })
  }
  
  shinyApp(ui, server)