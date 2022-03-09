library(shiny)
library(fpp3)
library(readr)

# Read zipped data
stocks <- read_csv("nyse_stocks.csv.zip")

# Convert to `tsibble()`
stocks$date <- as.Date(stocks$date)
stocks <- tsibble(stocks, index = date, key = symbol)

# Filter stocks we want
selected_stocks <- stocks %>%
  filter(symbol %in% c('AAPL', 'GOOG', 'FISV', 'FIS', 'IBM', 'EBAY', 'ADBE', 'HPQ', 'ORCL', 'YHOO'))

ui <- fluidPage(
  #checkbox instead of drop down so we can select multiple
  checkboxGroupInput(inputId = "select",
              label = "Select a Stock", 
              choices = c("Apple" = "AAPL", "Google" = "GOOG", "Fiserv" = "FISV", "FIS" = "FIS", "IBM" = "IBM", "Ebay" = "EBAY", "Adobe" = "ADBE", "HP" = "HPQ", "Oracle" = "ORCL", "Yahoo" = "YHOO"),
              selected = "AAPL"),
  dateRangeInput(
    'date',
    'Select a Date Range',
    start = min(stocks$date),
    end = max(stocks$date),
    ),
  
  plotOutput("Stock_Graph")
)

server <- function(input, output){
  output$Stock_Graph <- renderPlot({ selected_stocks %>%
      filter(symbol == input$select) %>%
      filter(max(stocks$date) >= input$date[1])
             (min(stocks$date) <= input$date[2]) %>%
      autoplot(open) +
      labs(title = "Info Tech Stocks", y = "Open", x = "Date")})
}

shinyApp(ui = ui, server = server)
