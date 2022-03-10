library(shiny)
library(fpp3)
library(readr)
library(plotly)
library(ggplot2)

# Read zipped data
stocks <- read_csv("nyse_stocks.csv.zip")

# Convert to `tsibble()`
stocks$date <- as.Date(stocks$date)
stocks <- tsibble(stocks, index = date, key = symbol)

# 1 stock
selected_stock <- "AAPL"

stocks %>%
  filter(symbol == selected_stock) %>%
  autoplot(open) +
  labs(title = selected_stock)

# Multiple stocks
selected_stocks <- c('AAPL', 'GOOG', 'FISV', 'FIS', 'IBM', 'EBAY', 'ADBE', 'HPQ', 'ORCL', 'YHOO')

stocks %>%
  filter(symbol %in% selected_stocks) %>%
  autoplot(open)

selected_stocks <- stocks %>%
  filter(symbol %in% c('AAPL', 'GOOG', 'FISV', 'FIS', 'IBM', 'EBAY', 'ADBE', 'HPQ', 'ORCL', 'YHOO'))
