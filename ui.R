# ui.R
library(dplyr)
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
    ),
    # Third Tab
    tabPanel("Scatter Plot",
             sidebarLayout(
               sidebarPanel(
                 "Pick Which Regression Lines You Want to See",
                 checkboxGroupInput("xvar",
                  label = "Choose from 3 Characteristics",
                  choices = list("Education" = "edu_corr",
                                 "Income Inequality" = "income_corr",
                                 "Racial Diversity" = "div_corr"))
                 ),
               mainPanel(plotlyOutput("scatter"))
             ),
             "use HTML or CSS to center this line in the middle of the page.
             This graph shows the overall trend between the variable(s) selected
             and the rate of hate crimes for each state. Check the boxes to 
             compare variables. See if you can find the answers to these 
             questions: 
             1. What kind of trend do you see between education and the rate
             of hate crimes?
             2. Can you accurately guess where your state falls on the trend line?
             Hover over each circle to check your guess!"
    )
  )
)
)