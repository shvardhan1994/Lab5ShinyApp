server <- function(input, output) {
  
  shiny::observeEvent(input$button_mun, {
    
    output$p <- shiny::renderPlot({
      source("./MunicipalityResults.r")
      MunicipalityResults(Municipality_name = (input$Municipality_name))
      
    })
  })
  
  shiny::observeEvent(input$button_coun, {
    
    output$p2 <- shiny::renderPlot({
      source("./CountyResults.R")
      CountyResults(County_name = (input$County_name))
      
      
    }) 
  }) 
}