library(shiny)
library(dplyr)
library(broom)
shinyServer(function(input, output,session) {
  #----data 1 for kmeans clust----
  set.seed(500)
  selectedData <- reactive({
    rbind(
      data_frame(x = rnorm(input$n), y = rnorm(input$n)),
      data_frame(r = rnorm(input$n, 5, .25), theta = runif(input$n, 0, 2 * pi),			  
                 x = r * cos(theta), y = r * sin(theta)) %>%
        dplyr::select(x, y)
    ) 
  })
  #----data2  for hclust use----
  selectedData_clust <- reactive({
    cbind(selectedData(),hclust_assignments=selectedData() %>%
            dist() %>% hclust(method = "single") %>%
            cutree(2) %>% factor()%>%as.data.frame()
    )
  })
  #-----plot-----
  output$plot <- renderPlot({
    switch(input$type,
           "kmeans" =( plot(selectedData(),
                            col = kmeans(selectedData(),2)$cluster,
                            pch = 20, cex = 1)
           ), 
           "hclust" = (plot(selectedData_clust()[,1:2],
                            col = selectedData_clust()[,3], 
                            pch = 20, cex = 1)
           )
    )
  })
  #----end---
})
