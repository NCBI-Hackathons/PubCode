# import libraries
library(shiny)
library(data.table)
library(ggplot2)
library(plotly)

# This file can be recreated in a reproducible fashion by running the script
# ../makeData-interactiveUIndex/makeData-interactiveUIndex.R
load("df.rda")

# Create static plot using ggplot package
g <- ggplot(data=df, aes(x=Year, y=uIndex, col=Paper)) + geom_line()
# Create interactive plot using ggplotly package
gp <- ggplotly(g)

server <- shinyServer(function(input, output) {

})

##################
# User Interface #
##################

#generic line initiating the UI
ui <- shinyUI(fluidPage(
  
  #Add a title
  titlePanel("Rendering U-Index Plot Interactive"),
  
  shiny::fluidRow("Below is a copy of Figure 2A from Callahan, A. et al. u-Index, a dataset and an impact metric for informatics tools and databases. Sci. Data 5:180043 doi: 10.1038/sdata.2018.43 (2018). It shows u-Index values over time for multiple sequence alignment tools. One problem with visualizing this type of dataset in a static format is the inability to zoom into the large number of tools that have low u-Index values. In this case, the authors solved this by providing an inset that zoomed into the data for the tools in the bottom-right corner of the main plot.", style='padding:10px;'),
  
  img(src='Figure2B-UIndex.jpeg', width=700, border="5"),
  
  shiny::fluidRow("Below, we attempt to recreate the above figure but as an interactive version. Unfortunately, there were four tools from the original figure above that we could not scrap the u-Indices for (guidance, embl-ebi, embl-ebiweb, and nast). However, we rendered the original plot interactive for all the other tools. You can now draw a box around a section of the plot to which you wish to zoom by clicking on the Zoom button (second from the left) in the toolbox in the top right corner of the plot.", style='padding:10px;'),
    
    gp

))

shinyApp(ui = ui, server = server)