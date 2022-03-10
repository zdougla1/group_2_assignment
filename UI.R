ui <- fluidPage(
  #checkbox instead of drop down so we can select multiple
  checkboxGroupInput(inputId = "select",
                     label = "Select a Stock", 
                     choices = c("Apple" = "AAPL", "Google" = "GOOG", "Fiserv" = "FISV", "FIS" = "FIS", "IBM" = "IBM", "Ebay" = "EBAY", "Adobe" = "ADBE", "HP" = "HPQ", "Oracle" = "ORCL", "Yahoo" = "YHOO"),
                     selected = "AAPL"),
  dateRangeInput(
    'date_range',
    'Select a Date Range',
    start = min(stocks$date),
    end = max(stocks$date),
    format = "yyyy-mm-dd"
  ),
  
  checkboxInput(inputId = "trendline",
                label = "Would you like to add a linear trend line?",
                value = TRUE),
  
  verbatimTextOutput("table_heading"),
  
  plotlyOutput("Stock_Graph"),
  
  verbatimTextOutput("max_close")
)







