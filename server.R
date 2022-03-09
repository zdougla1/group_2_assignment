server <- function(input, output){
  
  output$Stock_Graph <- renderPlot({ 
    p1 <- selected_stocks %>%
      filter(symbol == input$select) %>%
      ggplot(aes(x = date, y = open, color = factor(symbol))) +
      scale_x_date(limit = input$date_range) +
      geom_line() +
      labs(title = "Info Tech Stocks", y = "Open (USD)", x = "Date")
    
    if(input$trendline == TRUE) {
      p1 <- p1 + geom_smooth(method = lm)
    }
    p1
  })
  
  output$max_close <- renderPrint({
    max_price <- selected_stocks %>%
      filter(symbol == input$select) %>%
      group_by(symbol) %>%
      filter(close == max(close)) %>%
      select(close)
    print("Max Closing Price and Date for Selected Stocks")
    max_price
  })
}

shinyApp(ui = ui, server = server)