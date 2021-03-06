library(dplyr)
library(plotly)
library(shiny)

# Accesses datasets and other data.
source("analysis.R")

# Defines a fluidPage. Uses external .css file to style application.
shinyUI(fluidPage(
  navbarPage("Factors Influencing Number of Hate Crimes",
    inverse = FALSE,
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
    tabsetPanel(
      type = "tabs",
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
      # Widget is two buttons that allows user to change output.
      # Outputs the plot and information.
      tabPanel(
        "2016 Election Effect",
        tags$h3("Effect of the 2016 Presidential Election on Number of Hate
                Crimes"),
        br(),
        plotlyOutput("interactive"),
        fluidRow(
          column(3,
            radioButtons("beforeOrAfter",
              "Select Timeframe:",
              choices = list(
                "Before 2016 Election" = "avg_hatecrimes_per_100k_fbi",
                "After 2016 Election" = "hate_crimes_per_100k_splc"
              )
            ),
            selected = "avg_hatecrimes_per_100k_fbi"
          )
        ),
        # Outputs the choropleth map.
        uiOutput("maps")
      ),

      # Defines the third tab, and two widgets in the sidebar.
      # Outputs the plot and information on the main panel.
      tabPanel(
        "Compare Crimes by State",
        tags$h3("Compare Average Annual Number of Hate Crimes Between
                Two States (2010-2015)"),
        br(),
        sidebarPanel(
          # Creates drop-down menu to allow user to select first state.
          selectInput("state1", "Select First State:",
            choices = states,
            selected = "District of Columbia"
          ),
          # Creates drop-down menu to allow user to select second state.
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
        tags$h3("Do Demographic Factors Influence the Rate of Hate Crimes?"),
        br(),
        sidebarLayout(
          sidebarPanel(
            "",
            # Creates a checkbox menu so the user can see up to 3 graphs
            # at once
            checkboxGroupInput("xvar",
              label = "Select Regression Lines You Wish to Compare:",
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
