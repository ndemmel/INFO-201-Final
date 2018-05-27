# server.R
library(plotly)
library(shiny)

shinyServer(function(input, output) {

  output$interactive <- renderPlotly({
    hate_crimes$hover <- with(hate_crimes, paste("Avg Hate Crimes per 100K: ",
                                hate_crimes$avg_hatecrimes_per_100k_fbi))
    l <- list(color = toRGB("white"), width = 2)
    
    # map projection/options
    g <- list(
      scope = 'usa',
      projection = list(type = 'albers usa'),
      showlakes = TRUE,
      lakecolor = toRGB('white')
    )
    
    p <- plot_geo(hate_crimes, locationmode = 'USA-states') %>%
      add_trace(
        z = hate_crimes$avg_hatecrimes_per_100k_fbi, 
        text = ~hover, 
        locations = hate_crimes$state,
        color = hate_crimes$avg_hatecrimes_per_100k_fbi, 
        colors = 'Blues'
      ) %>%
      colorbar(title = "Number of Hate Crimes Per 100k") %>%
      layout(
        title = 'Average Annual Hate Crimes By State',
        geo = g
      )
    
  })
  
})
