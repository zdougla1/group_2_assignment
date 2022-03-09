ui <- fluidPage(
  #checkbox instead of drop down so we can select multiple
  checkboxGroupInput(inputId = "select",
                     label = "Select a Stock", 
                     choices = c("Apple" = "AAPL", "Google" = "GOOG", "Fiserv" = "FISV", "FIS" = "FIS", "IBM" = "IBM", "Ebay" = "EBAY", "Adobe" = "ADBE", "HP" = "HPQ", "Oracle" = "ORCL", "Yahoo" = "YHOO"),
                     selected = "AAPL"),
  dateRangeInput(
    input = 'date',
    label = 'Select open and close dates to view',
    start = stocks$open,
    end = stocks$close,
    min = stocks$open,
    max = stocks$close,
    format = 'yyyy-mm-dd',
    separator = 'to'
  ),
  plotOutput("Stock_Graph")
)







