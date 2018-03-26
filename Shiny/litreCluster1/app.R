library(shinydashboard)
library(shiny)
library(plotly)
library(hexbin)
library(htmlwidgets)
library(dplyr)
library(tidyr)
library(data.table)
library(RColorBrewer)
library(Hmisc)
library(shinycssloaders)

options(spinner.color.background="#F5F5F5")

load("soybean_ir.rda")
dat <- soybean_ir
dat <- dat[,1:7]
dat[,-1] <- log(dat[,-1]+1)
datCol <- colnames(dat)[-which(colnames(dat) %in% "ID")]
myPairs <- unique(sapply(datCol, function(x) unlist(strsplit(x,"[.]"))[1]))
load("cluster1_metrics.rda")
myMetrics <- colnames(metrics[[1]])[-which(colnames(metrics[[1]]) %in% "ID")]
values <- reactiveValues(x=0, selPair=NULL, selMetric=NULL, selOrder=NULL)

sidebar <- dashboardSidebar(
  width = 180,
  hr(),
  sidebarMenu(id="tabs",
    shinydashboard::menuItem("Application", tabName="hexPlot"),
    shinydashboard::menuItem("About", tabName = "about", selected=TRUE)
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "hexPlot",
      fluidRow(
        column(width = 4, 
         box(width = NULL, status = "primary", title = "Plot metrics", solidHeader = TRUE,
           selectizeInput("selPair", "Treatment pairs:", choices = myPairs, multiple = TRUE, options = list(maxItems = 2)),
           selectInput("selMetric", "Metric:", choices = myMetrics, selected = "FDR"),
           selectInput("selOrder", "Metric order:", choices = c("Increasing", "Decreasing")),
           numericInput("binSize", "Hexagon size:", value = 10, min = 1),
           numericInput("pointSize", "Point size:", value = 8, min = 1),
           actionButton("goButton", "Plot gene!"))),
        column(width = 8,
           box(width = NULL, withSpinner(plotlyOutput("hexPlot")), collapsible = FALSE, background = "black", title = "Litre plot", status = "primary", solidHeader = TRUE))),
    
      fluidRow(
        column(width = 12,
         box(width = NULL, withSpinner(plotlyOutput("boxPlot")), collapsible = FALSE, background = "black", title = "Parallel coordinate plot", status = "primary", solidHeader = TRUE))),
      
      fluidRow(
        column(width = 12,
               box(width = NULL, verbatimTextOutput("info1"), verbatimTextOutput("info2"), collapsible = TRUE, title = "Gene metrics", status = "primary", solidHeader = TRUE)))),
  shinydashboard::tabItem(tabName = "about",
    shiny::fluidRow("This application allows users to superimpose a differentially expressed gene of interest onto a litre plot. In the litre plot, each gene is plotted once for every combination of replicate pairs between treatment groups. The data we use for the examples below are published RNA-seq data of soybean developmental stages (Brown and Hudson, 2015). They contain two treatments (S1 and S2), each with three replicates. Hence, there are nine ways to pair a replicate from one treatment group with a replicate from the other treatement group (S1.1 and S2.1, S1.1 and S2.2, S1.1 and S2.3, S1.2 and S2.1, S1.2 and S2.2, S1.2 and S2.3, and S1.3 and S2.1, S1.3 and S2.2, and S1.3 and S2.3).", style='padding:10px;'),
    shiny::fluidRow("As a result, each gene for this dataset can be plotted as nine points to construct the litre plot. However, with 73,320 genes in this dataset, we would have 659,880 points. In interactive versions of the plot, this would reduce the speed of the functionality as well as cause overplotting problems. As a result, we use hexagon bins to construct the background of the litre plot as is shown in the right side of Figure 1 shown below.", style='padding:10px;'),
    shiny::fluidRow("This application comes with several input fields as is shown on the left side of Figure 1. The user must choose exactly two treatment groups in the 'Treatment Pairs' tab. They must choose an order (increasing or decreasing) in which to scroll through genes by a metric of choice. We see in Figure 1 that the user chose to superimpose the genes by increasing order of FDR values between S1 and S2.", style='padding:10px;'),
    shiny::fluidRow("Upon making these decisions, the user can then select the 'Plot gene!' button to superimpose each gene one by one onto the litre plot. In Figure 1, we see this as nine orange points that show high values for S2 and low values for S1. This gene is also superimposed as an orange parallel coordinate line on top of a box plot as shown in Figure 2. Moreover, the gene ID and its metric values are output as shown in Figure 3. We can determine that the gene we are viewing ranks third by our metric and order parameters. This  means the user has hit the 'Plot gene!' button three times now for this set of parameters and that this gene has the third lowest FDR value between S1 and S2 for this dataset.", style='padding:10px;'),
    shiny::fluidRow("Go ahead and test this application by switching to the 'Application' tab on the left side of the screen. The data you can interactively examine in that application include the 2751 significant genes (FDR<0.05) from Cluster 1 in a publicly available RNA-seq dataset related to iron metabolism in soybeans (Lauter et al., 2014).", style='padding:10px;'),
    br(),
    br(),
    div(p('Figure 1'), style="text-align: center;"),
    div(img(src='Figure1.png', style="width: 75%; height: 75%"), style="text-align: center;"),
    br(),
    br(),
    div(p('Figure 2'), style="text-align: center;"),
    div(img(src='Figure2.png', style="width: 75%; height: 75%"), style="text-align: center;"),
    br(),
    br(),
    div(p('Figure 3'), style="text-align: center;"),
    div(img(src='Figure3.png', style="width: 75%; height: 75%"), style="text-align: center;"), 
    br(),
    shiny::fluidRow("1. Brown, A.V. and Hudson, K.A. (2015) Developmental profiling of gene expression in soybean trifoliate leaves and cotyledons.", em(" BMC Plant Biology, "), strong("15"), ", 169.", style='padding:10px;'), 
    shiny::fluidRow("2. Moran Lauter, A.N., Peiffer, G.A., Yin, T., Whitham, S.A., Cook, D., and Shoemaker, R.C. (2014) Identification of candidate genes involved in early iron deficiency chlorosis signaling in soybean (glycine max) roots and leaves.", em(" BMC Genomics, "), strong("15"), ", 1-25.", style='padding:10px;')
  )))
  
ui <- shinydashboard::dashboardPage(
  shinydashboard::dashboardHeader(title = "Overlaying genes", titleWidth = 180),
  sidebar,
  body
)

server <- function(input, output, session) {
  
  observeEvent(input$goButton, values$x <- values$x + 1)
  observeEvent(input$selPair, values$x <- 0)
  observeEvent(input$selMetric, values$x <- 0)
  observeEvent(input$selOrder, values$x <- 0)
  observeEvent(input$binSize, values$x <- 0)
  
  observeEvent(input$selPair, values$selPair <- input$selPair)
  
  # Create data subset based on two letters user chooses
  datSel <- eventReactive(input$selPair, {
    validate(need(length(input$selPair) == 2, "Select a pair of treatments."))
    sampleIndex <- reactive(which(sapply(colnames(dat), function(x) unlist(strsplit(x,"[.]"))[1]) %in% c(input$selPair[1], input$selPair[2])))
    dat[,c(1, sampleIndex())]
  }, ignoreNULL = FALSE)
  
  metricDF <- eventReactive(c(input$selPair, input$selMetric, input$selOrder), {
    metricDF <- metrics[[paste0(input$selPair[1], "_", input$selPair[2])]]
    if (!is.null(metricDF[[input$selMetric]])){
      metricDF <- metricDF[order(metricDF[[input$selMetric]]),]
      if (input$selOrder == "Decreasing"){
        metricDF <- metricDF[order(-metricDF[[input$selMetric]]),]
      }
    }
    metricDF
  })
  
  currMetric <- eventReactive(values$x, {
    validate(need(values$x > 0, "Plot a gene."))
    metricDF()[values$x, ]})
  currID <- eventReactive(currMetric(), {as.character(currMetric()$ID)})
  currGene <- eventReactive(currID(), {unname(unlist(datSel()[which(datSel()$ID == currID()), -1]))})
  
  output$info1 <- renderPrint({ print(currMetric(), row.names = FALSE) })
  output$info2 <- renderPrint({ cat("Gene rank:", values$x) })
  
  output$hexPlot <- renderPlotly({
    
    sampleIndex1 <- which(sapply(colnames(datSel()), function(x) unlist(strsplit(x,"[.]"))[1]) %in% c(input$selPair[1]))
    sampleIndex2 <- which(sapply(colnames(datSel()), function(x) unlist(strsplit(x,"[.]"))[1]) %in% c(input$selPair[2]))
    
    minVal = min(datSel()[,-1])
    maxVal = max(datSel()[,-1])
    maxRange = c(minVal, maxVal)
    xbins= input$binSize
    buffer = (maxRange[2]-maxRange[1])/(xbins/2)
    x <- c()
    y <- c()
    for (i in 1:length(sampleIndex1)){
      for (j in 1:length(sampleIndex2)){
        x <- c(x, unlist(datSel()[,(sampleIndex1[i])]))
        y <- c(y, unlist(datSel()[,(sampleIndex2[j])]))
      }
    }
    
    h <- hexbin(x=x, y=y, xbins=xbins, shape=1, IDs=TRUE, xbnds=maxRange, ybnds=maxRange)
    hexdf <- data.frame (hcell2xy (h),  hexID = h@cell, counts = h@count)
    attr(hexdf, "cID") <- h@cID
    
    # By default, groups into six equal-sized bins
    hexdf$countColor <- cut2(hexdf$counts, g=6)
    hexdf$countColor2 <- as.factor(unlist(lapply(as.character(hexdf$countColor), function(x) substring(strsplit(gsub(" ", "", x, fixed = TRUE), ",")[[1]][1], 2))))
    
    hexdf$countColor2 <- factor(hexdf$countColor2, levels = as.character(sort(as.numeric(levels(hexdf$countColor2)))))
    
    for (i in 1:(length(levels(hexdf$countColor2))-1)){
      levels(hexdf$countColor2)[i] <- paste0(levels(hexdf$countColor2)[i],"-",levels(hexdf$countColor2)[i+1])
    }
    levels(hexdf$countColor2)[length(levels(hexdf$countColor2))] <- paste0(levels(hexdf$countColor2)[length(levels(hexdf$countColor2))], "+")
    
    my_breaks = levels(hexdf$countColor2)
    clrs <- brewer.pal(length(my_breaks)+3, "Blues")
    clrs <- clrs[3:length(clrs)]
    
    p <- reactive(ggplot(hexdf, aes(x=x, y=y, hexID=hexID, counts=counts, fill=countColor2)) + geom_hex(stat="identity") + scale_fill_manual(labels = as.character(my_breaks), values = rev(clrs), name = "Gene count") + geom_abline(intercept = 0, color = "red", size = 0.25) + labs(x = paste0("Read count ", "(", input$selPair[1], ")"), y = paste0("Read count ", "(", input$selPair[2], ")")) + theme(axis.text=element_text(size=15), axis.title=element_text(size=15), legend.title=element_text(size=15), legend.text=element_text(size=15)) + coord_fixed(ratio=1))
    
    gP <- eventReactive(p(), {
      gP <- ggplotly(p(), height = 400) #  height = 400
      for (i in 1:(length(gP$x$data)-1)){
        info <- gP$x$data[i][[1]]$text
        info2 <- strsplit(info,"[<br/>]")
        myIndex <- which(startsWith(info2[[1]], "counts:"))
        gP$x$data[i][[1]]$text <- info2[[1]][myIndex]
      }
      gP$x$data[length(gP$x$data)][[1]]$text <- NULL
      gP
    })
    
    plotlyHex <- reactive(gP() %>% config(displayModeBar = F))
    
    # Use onRender() function to draw x and y values of selected row as orange point
    plotlyHex() %>% onRender("
   function(el, x, data) {
   noPoint = x.data.length;
   Shiny.addCustomMessageHandler('points', function(drawPoints) {
   if (x.data.length > noPoint){
   Plotly.deleteTraces(el.id, x.data.length-1);
   }
   var Traces = [];
   var trace = {
   x: drawPoints.geneX,
   y: drawPoints.geneY,
   mode: 'markers',
   marker: {
   color: '#00BF7D',
   size: drawPoints.pointSize
   },
   hoverinfo: 'none',
   showlegend: false
   };
   Traces.push(trace);
   Plotly.addTraces(el.id, Traces);
   });}")
  })
  
  observe({
    # Get x and y values of selected row
    sampleIndex1 <- which(sapply(colnames(datSel()), function(x) unlist(strsplit(x,"[.]"))[1]) %in% c(input$selPair[1]))
    sampleIndex2 <- which(sapply(colnames(datSel()), function(x) unlist(strsplit(x,"[.]"))[1]) %in% c(input$selPair[2]))
    
    geneX <- c()
    geneY <- c()
    for (i in 1:length(sampleIndex1)){
      for (j in 1:length(sampleIndex2)){
        geneX <- c(geneX, currGene()[sampleIndex1[i]-1])
        geneY <- c(geneY, currGene()[sampleIndex2[j]-1])
      }
    }
    
    pointSize <- input$pointSize
    
    # Send x and y values of selected row into onRender() function
    session$sendCustomMessage(type = "points", message=list(geneX=geneX, geneY=geneY, pointSize = pointSize))
  })
  
  output$boxPlot <- renderPlotly({
    nVar = reactive(ncol(datSel()))
    colNms <- reactive(colnames(datSel()[, c(2:nVar())]))
    
    boxDat <- eventReactive(datSel(), {
      boxDat <- datSel()[, c(1:nVar())] %>% gather(key, val, -c(ID))
      colnames(boxDat) <- c("ID", "Sample", "Count")
      boxDat
    })
    
    BP <- reactive(ggplot(boxDat(), aes(x = Sample, y = Count)) + geom_boxplot() + labs(y = "Read count"))
    ggBP <- reactive(ggplotly(BP(), width=600, height = 400) %>% config(displayModeBar = F, staticPlot = T))
    
    observe({
      session$sendCustomMessage(type = "lines", currGene())
    })
    
    ggBP() %>% onRender("
    function(el, x, data) {
    
    console.log(['x', x])
    console.log(['x.data.length', x.data.length])
    noPoint = x.data.length;
    
    function range(start, stop, step){
    var a=[start], b=start;
    while(b<stop){b+=step;a.push(b)}
    return a;
    };
    
    Shiny.addCustomMessageHandler('lines',
    function(drawLines) {
    
    i = x.data.length
    if (i > 1){
    while (i > 1){
    Plotly.deleteTraces(el.id, (i-1));
    i--;
    }
    }
    
    var dLength = drawLines.length
    
    var Traces = [];
    var traceLine = {
    x: range(1, dLength, 1),
    y: drawLines,
    mode: 'lines',
    line: {
    color: '#00BF7D',
    width: 2
    },
    opacity: 0.9,
    hoverinfo: 'none'
    }
    Traces.push(traceLine);
    Plotly.addTraces(el.id, Traces);
    })
    }")})
}

shiny::shinyApp(ui = ui, server = server)
