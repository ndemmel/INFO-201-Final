# server.R
library(plotly)
library(shiny)
library(ggplot2)
library(knitr)

shinyServer(function(input, output) {
  output$introduction <- renderUI({
    HTML(markdown::markdownToHTML(knit('introduction.md', quiet = TRUE)))
  })
  
  output$interactive <- renderPlotly({
    # map projection/options
    g <- list(
      scope = "usa",
      projection = list(type = "albers usa"),
      showlakes = TRUE,
      lakecolor = toRGB("white")
    )
    
    p <- plot_geo(hate_crimes, locationmode = "USA-states") %>%
      add_trace(
        z = hate_crimes[[input$beforeOrAfter]],
        text = paste(hate_crimes[[input$beforeOrAfter]]),
        locations = ~code,
        color = hate_crimes[[input$beforeOrAfter]],
        colors = 'Purples'
      ) %>%
      colorbar(title = "Number Per 100K Population"
      ) %>%
      layout(
        title = "Average Number of Hate Crimes by State",
        geo = g
      )
  })
  
  output$comparison <- renderPlot({
    state_one_crimes <- hate_crimes %>%
      filter(state == input$state1) %>%
      select(avg_hatecrimes_per_100k_fbi)
    sum_state_one_crimes <- sum(state_one_crimes)
    state_two_crimes <- hate_crimes %>%
      filter(state == input$state2) %>%
      select(avg_hatecrimes_per_100k_fbi)
    sum_state_two_crimes <- sum(state_two_crimes)
    both_state_crimes <- c(sum_state_one_crimes, sum_state_two_crimes)
    
    barplot(
      both_state_crimes,
      names.arg = c(input$state1, input$state2),
      xlab = "State", ylab = "Average annual hate crimes per 100,000 people",
      ylim = c(0, 12), col = c("Light Blue", "Coral"),
      main = "Number of Hate Crimes per 100,000 by State"
    )
    text(0.7, 6, paste0("(", sum_state_one_crimes, ")"))
    text(1.9, 6, paste0("(", sum_state_two_crimes, ")"))
  })
  
  output$scatter <- renderPlotly({
    interactive_scatterplot <- plot_ly(hate_crimes_minus_DC,
                                       x = input$xvar,
                                       y = hate_crimes_minus_DC$avg_hatecrimes_per_100k_fbi),
                                       type = "scatter",
                                       mode = "lines" %>%
      layout(title = paste0(input$xvar, " vs Hate Crime Rate")) %>%
      add_trace(
        text = ~state)
  })
})