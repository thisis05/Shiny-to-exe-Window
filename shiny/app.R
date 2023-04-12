#example Shiny app of https://github.com/thisis05/ShinyBasic

library(shiny)
library(data.table)
library(DT)
source("global.R")


ui <- navbarPage("MTCARS",
                 tabPanel("Data",
                          mainPanel(
                            DTOutput("data")
                          )
                 ),
                 tabPanel("Table",
                          sidebarPanel(
                            selectInput("var", "Select Variables", 
                                        choices = setdiff(names(data), "mpg_group"), 
                                        selected = setdiff(names(data), "mpg_group"), multiple = T)
                          ),
                          mainPanel(
                            DTOutput("table"),
                          )
                 ),
                 tabPanel("Plot",
                          sidebarPanel(
                            radioButtons("xvar", "X variable",
                                         choices = setdiff(names(data), "mpg_group"),
                                         selected = "mpg"),
                            radioButtons("yvar", "y variable",
                                         choices = setdiff(names(data), "mpg_group"),
                                         selected = "wt")
                          ),
                          mainPanel(
                            plotOutput("plot")
                          )
                 )
)





server <- function(input, output) {
  
  output$data <- renderDT({
    DT::datatable(data, rownames = F,  caption = "Mtcars data set")
  })
  
  output$table <- renderDT({
    table_data <- data[, lapply(.SD, function(x){round(mean(x), 2)}), by = mpg_group, .SDcols = input$var]
    DT::datatable(table_data, rownames = F,  caption = "Mtcars data mean by Mpg")
  })
  
  output$plot <- renderPlot({
    plot(data[[input$xvar]], data[[input$yvar]], main = paste0(input$xvar, " - ", input$yvar, " (cor : ", round(cor(data[[input$xvar]], data[[input$yvar]]),3), ")"),
         xlab = input$xvar, ylab= input$yvar, pch=20, cex = 2, col = "blue")
  })
  
}


shinyApp(ui = ui, server = server)
