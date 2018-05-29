# ui.Rlibrary(dplyr)
library(plotly)
library(shiny)

# access datasets
source("analysis.R")

# create Shiny UI
shinyUI(fluidPage(
  navbarPage("Factors Influencing Rate of Hate Crimes", inverse = FALSE,
             tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
             
             # INTRODUCTION
             tabPanel("Introduction", mainPanel(uiOutput("introduction"))),
             
             # FIRST TAB
             tabPanel("2016 Election",
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
             ),
             
             
             # THIRD TAB
             
             tabPanel("Scatter Plot",
                      sidebarLayout(
                        sidebarPanel(
                          "Pick Which Regression Lines You Wish to Compare",
                          checkboxGroupInput("xvar",
                                             label = "Choose from 3 Characteristics",
                                             choices = list("Education" = "Education",
                                                            "Income Inequality" = "Income Inequality",
                                                            "Racial Diversity" = "Racial Diversity"),
                                             selected = "Education")
                        ),
                        mainPanel(plotlyOutput("scatter"))
                      ),
                      "This graph shows the overall trend between the variable(s) selected
                      and the rate of hate crimes for each state. Check the boxes to 
                      compare variables. See if you can find the answers to these 
                      questions: 
                      1. What kind of trend do you see between education and the rate
                      of hate crimes?
                      2. Can you accurately guess where your state falls on the trend line?
                      Hover over each circle to check your guess!"
             )
             )
             ))