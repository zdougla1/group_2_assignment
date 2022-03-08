server <- function(input, output){
  output$Stock_Graph <- renderPlot({ selected_stocks %>%
      filter(symbol == input$select) %>%
      autoplot(open) +
      labs(title = "Info Tech Stocks", y = "Open", x = "Date")})
}

shinyApp(ui = ui, server = server)