library(data.table)
library(ggplot2)
library(plotly)

# Read UI-index datasets from Callahan, A. et al. doi: 10.1038
datList = list()
k = 143619
for (i in 2000:2015){
  datList[[i]] <- fread(paste0('https://datadryad.org/bitstream/handle/10255/dryad.', k, '/uindex_', i, '.csv?sequence=1'))
  k=k+1
}

# Multiple sequence alignment tools plotted in Figure 2A from Callahan, A. et al. doi: 10.1038
paperVector = c("muscle","clustal","mafft","guidance","embl-ebi","nast","embl-ebiweb","tcoffee","endscript","kalign","expresso")

# Create a data frame that contains the uIndex for each year for each paper in paperVector
df = setNames(data.frame(matrix(ncol = 3, nrow = 0)), c("Year", "uIndex", "Paper"))
for (j in 1:length(paperVector)){
  for (i in 2000:2015){
    currUIndex = datList[[i]][which(key==paperVector[j]),]$u_index
    # Set the value to "NA" if there is no uIndex for given year and paper
    if (length(currUIndex)==0){
      currUIndex = "NA"
    }
    df = rbind(df, cbind(Year=i, uIndex=currUIndex, Paper = paperVector[j]))
  }
}

# For some reason, the papers c("guidance","embl-ebi","nast","embl-ebiweb") do not have a key in the UI-index datasets from Callahan, A. et al.

# Remove rows that have uIndex with value "NA" or "NULL"
df = df[which(df$uIndex!="NA"),]
df = df[which(df$uIndex!="NULL"),]

# Change the columns of data frame so in correct format for interactive plot
df$Year = as.numeric(as.character(df$Year))
df$uIndex = as.numeric(as.character(df$uIndex))
df$Paper = as.character(df$Paper)

# Create static plot using ggplot package
g <- ggplot(data=df, aes(x=Year, y=uIndex, col=Paper)) + geom_line()
# Create interactive plot using ggplotly package
gp <- ggplotly(g)
# Plot interactive plot
gp


