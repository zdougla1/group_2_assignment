library(shiny)
library(fpp3)
library(readr)
library(ggplot2)
library(plotly)

# Read zipped data
stocks <- read_csv("nyse_stocks.csv.zip")

# Convert to `tsibble()`
stocks$date <- as.Date(stocks$date)
stocks <- tsibble(stocks, index = date, key = symbol)

# Filter stocks we want
selected_stocks <- stocks %>%
  filter(symbol %in% c('AAPL', 'GOOG', 'FISV', 'FIS', 'IBM', 'EBAY', 'ADBE', 'HPQ', 'ORCL', 'YHOO'))

ui <- fluidPage(
  
  h1("Stock Data App"),
  
  #checkbox instead of drop down so we can select multiple
  checkboxGroupInput(inputId = "select",
                     label = "Select a Stock", 
                     choices = c("Apple" = "AAPL", "Google" = "GOOG", "Fiserv" = "FISV", "FIS" = "FIS", "IBM" = "IBM", "Ebay" = "EBAY", "Adobe" = "ADBE", "HP" = "HPQ", "Oracle" = "ORCL", "Yahoo" = "YHOO"),
                     selected = "AAPL"),
  dateRangeInput(inputId = 'date_range',
    label = 'Select a Date Range',
    start = min(stocks$date),
    end = max(stocks$date),
    format = "yyyy-mm-dd"
  ),
  
  checkboxInput(inputId = "trendline",
                label = "Would you like to add a linear trend line?",
                value = TRUE),
  
  plotlyOutput("Stock_Graph"),
  
  verbatimTextOutput("table_heading"),
  
  tableOutput("max_close")

)

server <- function(input, output){
  
  output$Stock_Graph <- renderPlotly({
    p1 <- selected_stocks %>%
      filter(symbol == input$select) %>%
      ggplot(aes(x = date, y = open, color = factor(symbol))) +
      scale_x_date(limit = input$date_range) +
      geom_line() +
      labs(title = "Selected Info Tech Stocks", y = "Open (USD)", x = "Date")
  
    if(input$trendline == TRUE) {
      p1 <- p1 + geom_smooth(method = lm)
    }
  p1
    })
  
  output$table_heading <- renderText({
    "Max Closing Price (USD) and Date for Selected Stocks"
  })
  
  output$max_close <- renderTable({
    max_price <- selected_stocks %>%
      filter(symbol == input$select) %>%
      group_by(symbol) %>%
      filter(close == max(close)) %>%
      select(close)
    max_price
  })
}

shinyApp(ui = ui, server = server)
