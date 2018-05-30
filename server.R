# server.R
library(plotly)
library(shiny)
library(ggplot2)
library(knitr)

shinyServer(function(input, output) {
  # render various Markdown files for tab explanations
  output$introduction <- renderUI({
    HTML(markdown::markdownToHTML(knit('markdown/introduction.md', quiet = TRUE)))
  })

  output$maps <- renderUI({
    HTML(markdown::markdownToHTML(knit('markdown/maps.md', quiet = TRUE)))
  })

  output$scatterinfo <- renderUI({
    HTML(markdown::markdownToHTML(knit('markdown/scatterplot.md', quiet = TRUE)))
  })

  output$conclusion <- renderUI({
    HTML(markdown::markdownToHTML(knit('markdown/conclusion.md', quiet = TRUE)))
  })

  output$barplot_info <- renderUI({
    HTML(markdown::markdownToHTML(knit('markdown/barplot_info.md', quiet = TRUE)))
  })

  output$interactive <- renderPlotly({
    # map projection/options
    g <- list(
      scope = "usa",
      projection = list(type = "albers usa"),
      showlakes = TRUE,
      lakecolor = toRGB("white")
    )


    p <- plot_geo(crimes_states, locationmode = "USA-states") %>%
      add_trace(
        z = ~ crimes_states[[input$beforeOrAfter]],
        locations = ~ crimes_states$locations,
        color = ~ crimes_states[[input$beforeOrAfter]],
        colors = "Purples"
      ) %>%

      colorbar(title = "Number Per 100K Population", limits = c(0, 0.9)) %>%
      layout(
        title = "Average Annual Number of Hate Crimes by State per 100,000 People",
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
      xlab = "State", ylab = "Average Annual Hate Crimes per 100K Population",
      ylim = c(0, 12), col = c("Light Blue", "Coral"),
      main = "Number of Hate Crimes per 100,000 by State"
    )
    text(0.7, 6, paste0("(", sum_state_one_crimes, ")"))
    text(1.9, 6, paste0("(", sum_state_two_crimes, ")"))
  })

  output$scatter <- renderPlotly({
    scatterplot <- plot_ly(hate_crimes_minus_DC,
      x = hate_crimes_minus_DC[[input$xvar[1]]],
      y = hate_crimes_minus_DC$avg_hatecrimes_per_100k_fbi,
      text = ""
    ) %>%
      layout(title = paste0("Significance of Social Factors on Rate of Hate Crimes"),
             xaxis = list(title = "Correlation Coefficient", range = c(0,3)),
             yaxis = list(title = "Avg Annual Hate Crimes per 100K Population"),
            showlegend = TRUE
    )
    for(column in input$xvar) {
      scatterplot <- add_markers(scatterplot,
                                 x = hate_crimes_minus_DC[[column]],
                                 y = hate_crimes_minus_DC$avg_hatecrimes_per_100k_fbi,
                                 color = column,
                                 text = ~paste(hate_crimes_minus_DC$state))
    }

    scatterplot
  })

})