ui <- fluidPage(
  #checkbox instead of drop down so we can select multiple
  checkboxGroupInput(inputId = "select",
                     label = "Select a Stock", 
                     choices = c("Apple" = "AAPL", "Google" = "GOOG", "Fiserv" = "FISV", "FIS" = "FIS", "IBM" = "IBM", "Ebay" = "EBAY", "Adobe" = "ADBE", "HP" = "HPQ", "Oracle" = "ORCL", "Yahoo" = "YHOO"),
                     selected = "AAPL"),
  
  plotOutput("Stock_Graph")
)







