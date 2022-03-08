server <- function(input, output){
  output$Stock_Graph <- renderPlot({ autoplot(input$select )})
}

shinyApp(ui, server)