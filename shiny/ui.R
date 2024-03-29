library(shiny)

vars <- setdiff(names(data_shiny), c("Znamka", "Model", "Motor", "Menjalnik","Cas_pridobitve_podatkov", "Celo_ime"))

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