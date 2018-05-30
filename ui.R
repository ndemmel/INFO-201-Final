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
    tabsetPanel(
      type = "tabs",
      # INTRODUCTION
      # Defines introduction tab, outputs text and image.
      tabPanel(
        "Introduction",
        br(), uiOutput("introduction"), br(),
        img(
          src = "hate-banner.png", align = "center",
          style = "display: block; margin-left: auto; margin-right: auto;"
        )
      ),

      # Defines the second tab, and one widget in the output.
      # Outputs the plot and information.
      tabPanel(
        "2016 Election",
        tags$h3("Affect of the 2016 Presidential Election on Rate of Hate
                Crimes"),
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
        uiOutput("maps")
      ),

      # Defines the third tab, and two widgets in the sidebar.
      # Outputs the plot and information on the main panel.
      tabPanel(
        "Compare States",
        tags$h3("Compare Average Annual Number of Hate Crimes Between
                Two States (2010-2015)"),
        br(),
        sidebarPanel(
          # Creates drop-down menu to allow user to select state.
          selectInput("state1", "Select First State:",
            choices = states,
            selected = "District of Columbia"
          ),
          # Creates drop-down menu to allow user to select state.
          selectInput("state2", "Select Second State:",
            choices = states,
            selected = "Wyoming"
          )
        ),
        # Outputs plot and information text.
        mainPanel(
          plotOutput("comparison"),
          uiOutput("barplot_info")
        )
      ),

      # Defines the fourth tab, and one widget in the sidebar.
      # Outputs the plot and information on the main panel.
      tabPanel(
        "Demographic Factors",
        tags$h3(""),
        br(),
        sidebarLayout(
          sidebarPanel(
            "Select Regression Lines You Wish to Compare",
            # Creates a checkbox menu so the user can see up to 3 graphs
            # at once
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
          # Renders the plot on the main panel and displays a caption beneath
          # the graph
          mainPanel(plotlyOutput("scatter"), br(), uiOutput("scatterinfo"))
        )
      ),

      # CONCLUSION
      # Defines conclusion tab, outputs text and image.
      tabPanel(
        "Conclusion",
        br(), uiOutput("conclusion"),
        h3("Our Team", align = "Center"),
        img(
          src = "Team.jpg", height = 190, width = 1000,
          style = "display: block; margin-left: auto; margin-right: auto;"
        )
      )
    )
  )
))
