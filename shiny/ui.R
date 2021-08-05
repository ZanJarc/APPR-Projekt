library(shiny)

vars <- setdiff(names(data), c("Znamka", "Model", "Cas", "Motor", "Cas_pridobitve_podatkov", "Celo_ime", "Menjalnik"))

pageWithSidebar(
  headerPanel('Pregled razvrščanja'),
  sidebarPanel(
    selectInput('xcol', 'X spremenljivka', vars),
    selectInput('ycol', 'Y spremenljivka', vars, selected = vars[[4]]),
    numericInput('clusters', 'Število razredov', 3, min = 2, max = 4)
  ),
  mainPanel(
    plotOutput('plot1')
  )
)