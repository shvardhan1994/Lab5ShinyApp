url <- "https://data.val.se/val/val2014/statistik/2014_riksdagsval_per_kommun.xls"
httr::GET(url = url, httr::write_disk(tfo <- tempfile(fileext = ".xls")))
get_data_temp_s <- readxl::read_excel(tfo, 1L, col_names = TRUE)
get_data_s <- get_data_temp_s[-1,]
colnames(get_data_s) <- c(get_data_s[1,])
get_data_s <- get_data_s[-1,]

shiny::shinyUI(bootstrapPage(
  
  shiny::titlePanel("Comprehensive statistics on the 2014 election in Sweden"),
  shiny::sidebarLayout(
    shiny::sidebarPanel(
      shiny::selectInput("Municipality_name","Municipality",
                         unique(as.character(get_data_s$Municipality))),
      shiny::actionButton("button_mun", "Municipality Results"),
      shiny::selectInput("County_name","County",
                         unique(as.character(get_data_s$County))),
      shiny::actionButton("button_coun", "County Results")
      
    ),
    shiny::mainPanel(shiny::plotOutput("p"),
                     shiny::br(),
                     shiny::br(),
                     shiny::plotOutput("p2"))
  )
  
))