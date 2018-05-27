# ui.R
library(dplyr)
library(ggplot2)
library(plotly)
library(shiny)

# access datasets
source("analysis.R")

# create Shiny UI
shinyUI(fluidPage(
  navbarPage("Factors Influencing Rate of Hate Crimes", inverse = TRUE,
    # FIRST TAB
    tabPanel("2016 Election",
      h3("Affect of the 2016 Presidential Election on Rate of Hate Crimes"),
      br(),
      plotlyOutput("interactive"),
      fluidRow(
        column(3,
          radioButtons("beforeOrAfter", 
            "Select Timeframe",
            choices = list("Before 2016 Election" = "avg_hatecrimes_per_100k_fbi",
                        "After 2016 Election" = "hate_crimes_per_100k_splc")),
            selected = "avg_hatecrimes_per_100k_fbi")
        )
      )
    )
    # SECOND TAB
  )
)