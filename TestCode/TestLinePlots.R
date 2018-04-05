# This script creates an interactive line plot for citations per year for a cluster of papers
# We will read in U-indices and citations/year

library(plotly)
library(ggplot2)

nPapers = 10
citeDF = setNames(data.frame(matrix(ncol = 3, nrow = 0)), c("Year", "Citations", "Paper"))

# Create a toy dataset
for (i in 1:nPapers){
  firstYear = sample(c(2010,2011,2012,2013,2014,2015,2016,2017), 1)
  nYears = 2018-firstYear
  currCitations = sort(sample(20:100, nYears, replace=T))
  currYear = seq(firstYear, firstYear+nYears-1, 1)
  if (i%%2==0){
    currCitations = sort(currCitations, decreasing = TRUE)
  }
  citeDF = rbind(citeDF, cbind(Year=currYear, Citations=currCitations, Paper = paste0("Paper", i)))
}
citeDF$Year = as.numeric(as.character(citeDF$Year))
citeDF$Citations = as.numeric(as.character(citeDF$Citations))
citeDF$Paper = as.character(citeDF$Paper)

# Plot static line plot
g <- ggplot(data=citeDF, aes(x=Year, y=Citations, col=Paper)) + geom_line()
# Plot interactive line plot
ggplotly(g)

