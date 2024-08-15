library(shiny)
library(deBInfer)

tagList(
  navbarPage(
    title = paste("AppAroundPackage", packageVersion("AppAroundPackage")),
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
          plotOutput("example_plot")
        ),
      )
    )
  ),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  )
)
