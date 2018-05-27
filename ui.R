# ui.R
library(dplyr)
library(ggplot2)
library(plotly)
library(shiny)

# access datasets
source("analysis.R")

# create Shiny UI
shinyUI(fluidPage(
  navbarPage("Factors Influencing Rate of Hate Crimes",
    # FIRST TAB
    tabPanel("Interactive Map",
      sidebarLayout(
        sidebarPanel(
          "Hello"
          ),
        mainPanel(plotlyOutput("interactive"))
      )
    )
  )
))