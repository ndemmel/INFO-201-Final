# server.R
library(plotly)
library(shiny)

shinyServer(function(input, output) {

  output$interactive <- renderPlotly({
    # map projection/options
    g <- list(
      scope = 'usa',
      projection = list(type = 'albers usa'),
      showlakes = TRUE,
      lakecolor = toRGB('white')
    )
    
    p <- plot_geo(hate_crimes, locationmode = 'USA-states') %>%
      add_trace(
        z = hate_crimes[[input$beforeOrAfter]], 
        text = hate_crimes[[input$beforeOrAfter]], 
        locations = ~code,
        color = hate_crimes[[input$beforeOrAfter]], 
        colors = 'Purples'
      ) %>%
      colorbar(title = "Number Per 100K Population"
      ) %>%
      layout(
        title = 'Average Number of Hate Crimes by State',
        geo = g
      )
  })
  
})
