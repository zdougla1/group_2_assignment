ui <- fluidPage(
  selectInput("select", label = "Select a Stock", 
              choices = list('AAPL' = 'Apple', 'GOOG' = 'Google', 'FISV' = 'Fiserv', 'FIS' = 'FIS', 'IBM' = 'IBM', 'EBAY' = 'Ebay', 'ADBE' = 'Adobe', 'HPQ' = 'HP', 'ORCL' = 'Oracle', 'YHOO' = 'Yahoo'), 
              multiple = TRUE),
  
  plotOutput("Stock_Graph")
)







