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
    inverse = TRUE,
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
    tabPanel("Introduction"),
    # FIRST TAB
    tabPanel(
      "2016 Election",
      tags$h3("Affect of the 2016 Presidential Election on Rate of Hate Crimes"),
      br(),
      plotlyOutput("interactive"),
      fluidRow(
        column(3,
          radioButtons("beforeOrAfter",
            "Select Timeframe",
            choices = list(
              "Before 2016 Election" = "avg_hatecrimes_per_100k_fbi",
              "After 2016 Election" = "hate_crimes_per_100k_splc"
            )
          ),
          selected = "avg_hatecrimes_per_100k_fbi"
        )
      )
    ),
    # SECOND TAB
    tabPanel(
      "Comparison Between States",
      sidebarPanel(
        selectInput("state1", "Select First State to Compare:",
          choices = list(
            "Alabama", "Alaska", "Arizona", "Arkansas", "California",
            "Colorado", "Connecticut", "Delaware",
            "District of Columbia", "Florida", "Georgia", "Hawaii",
            "Idaho", "Illinois", "Indiana", "Iowa", "Kansas",
            "Kentucky", "Louisiana", "Maine", "Maryland",
            "Massachusetts", "Michigan", "Minnesota", "Mississippi",
            "Missouri", "Montana", "Nebraska", "Nevada",
            "New Hampshire", "New Jersey", "New Mexico", "New York",
            "North Carolina", "North Dakota", "Ohio", "Oklahoma",
            "Oregon", "Pennsylvania", "Rhode Island",
            "South Carolina", "South Dakota", "Tennessee", "Texas",
            "Utah", "Vermont", "Virginia", "Washington",
            "West Virginia", "Wisconsin", "Wyoming"
          ),
          selected = "District of Columbia"
        ),
        selectInput("state2", "Select Second State to Compare:",
          choices = list(
            "Alabama", "Alaska", "Arizona", "Arkansas", "California",
            "Colorado", "Connecticut", "Delaware",
            "District of Columbia", "Florida", "Georgia", "Hawaii",
            "Idaho", "Illinois", "Indiana", "Iowa", "Kansas",
            "Kentucky", "Louisiana", "Maine", "Maryland",
            "Massachusetts", "Michigan", "Minnesota", "Mississippi",
            "Missouri", "Montana", "Nebraska", "Nevada",
            "New Hampshire", "New Jersey", "New Mexico", "New York",
            "North Carolina", "North Dakota", "Ohio", "Oklahoma",
            "Oregon", "Pennsylvania", "Rhode Island",
            "South Carolina", "South Dakota", "Tennessee", "Texas",
            "Utah", "Vermont", "Virginia", "Washington",
            "West Virginia", "Wisconsin", "Wyoming"
          ),
          selected = "Wyoming"
        )
      ),
      mainPanel(
        plotOutput("comparison")
      )
    )
  )
))
