# ui.R
library(dplyr)
library(plotly)
library(shiny)

# access datasets
source("analysis.R")

# create Shiny UI
shinyUI(fluidPage(
  navbarPage("Factors Influencing Rate of Hate Crimes",
    inverse = FALSE,
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
    tags$style(type = "text/css", "a{color: #191970;}", "bold"),
    tabsetPanel(type = "tabs",
      # INTRODUCTION
      tabPanel(
        "Introduction",
        br(), uiOutput("introduction"), br(),
        img(src="hate-banner.png", align = "center",
            style = "display: block; margin-left: auto; margin-right: auto;")
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
        ),
        uiOutput("maps")),

      # SECOND TAB
      tabPanel(
        "Compare States",
        tags$h3("Compare Average Annual Number of Hate Crimes Between Two States (2010-2015)"),
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
          plotOutput("comparison"),
          uiOutput("barplot_info")
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

      # CONCLUSION
      tabPanel(
        "Conclusion",
        br(), uiOutput("conclusion"),
        h3("Our Team", align = "Center"),
        img(
          src = "Team.jpg", height = 205, width = 1000, 
          style = "display: block; margin-left: auto; margin-right: auto;"
        )
      )
    )
  )
))