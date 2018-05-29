# ui.R
library(dplyr)
library(plotly)
library(shiny)

# access datasets
source("analysis.R")

# create Shiny UI
shinyUI(fluidPage(
  navbarPage("Factors Influencing Rate of Hate Crimes",
    inverse = TRUE,
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),

    tabsetPanel(
      # INTRODUCTION
      tabPanel(
        "Introduction",
        mainPanel(uiOutput("introduction"))
      ),

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
        "Compare States",
        tags$h3("Compare Rate of Hate Crimes Between Two States"),
        br(),
        sidebarPanel(
          selectInput("state1", "Select First State:",
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
          selectInput("state2", "Select Second State:",
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
      ),

      # THIRD TAB
      tabPanel(
        "Demographic Factors",
        tags$h3(""),
        br(),
        sidebarLayout(
          sidebarPanel(
            "Select Regression Lines You Wish to Compare",
            checkboxGroupInput("xvar",
              label = "Choose from 3 Characteristics",
              choices = list(
                "Education" = "Education",
                "Income Inequality" = "Income Inequality",
                "Racial Diversity" = "Racial Diversity"
              ),
              selected = "Education"
            )
          ),
          mainPanel(plotlyOutput("scatter"), uiOutput("scatterinfo")))
      ),

      # Final Tab

      tabPanel(
        "Conclusion",
        mainPanel(uiOutput("conclusion"), align = "Center"),
        h3("~Our Team~", align = "Center"),
        img(
          src = "Team.jpg", width = 1000, style = "display: block; margin-left: auto; margin-right: auto;"
        )
      )
    )
  )
))