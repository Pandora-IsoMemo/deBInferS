library(shiny)
library(deBInfer)

tagList(
  navbarPage(
    title = paste("deBInferS", packageVersion("deBInferS")),
    theme = shinythemes::shinytheme("flatly"),
    position = "fixed-top",
    collapsible = TRUE,
    id = "tab",
    tabPanel(
      title = "Tab",
      sidebarLayout(
        sidebarPanel(
          width = 2,
          actionButton("example", "Create Example")
        ),
        mainPanel(
          plotOutput("example_plot_1"),
          plotOutput("example_plot_2"),
          plotOutput("example_plot_3")
        ),
      )
    )
  ),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  )
)
