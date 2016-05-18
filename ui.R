library(shiny)
library(dplyr)
library(broom)
shinyUI(
  pageWithSidebar(
    #  Application title
    headerPanel("kmeans VS hclust"),
    sidebarPanel(
      numericInput('n', 'Number of obs', 500 ,min=200 ,max=1000),
      selectInput("type", "Select a clust approach:",c("kmeans","hclust"),"kmeans")
    ),
    mainPanel(plotOutput("plot"))
  )
)
