library(reshape)

##################################################
# Create interactive plot for PMID citations each year

dat <- read.csv("../docs/Data/CitationsYear.csv")
dat <- dat[1:20,]
# We do not grab 2018 because its data is not yet full
dat <- dat[,c(1,11:3)]
colnames(dat) <- c("Software", 2009:2017)
mdata <- melt(dat, id=c("Software"))
mdata <- mdata[which(!is.na(mdata$value)),]
colnames(mdata) <- c("Software", "Year", "Citations")
mdata$Year = as.numeric(as.character(mdata$Year))
mdata$Citations = as.numeric(as.character(mdata$Citations))
mdata$Software = as.character(mdata$Software)
# Plot static line plot
g <- ggplot(data=mdata, aes(x=Year, y=Citations, col=Software)) + geom_line() + theme(legend.position="none")
# Plot interactive line plot
ggplotly(g)

##################################################
# Create interactive plot for u-Index values

dat <- read.csv("../docs/Data/CitationsYearUIndex.csv")
colnames(dat) <- c("Software", 2000:2015)
mdata <- melt(dat, id=c("Software"))
mdata <- mdata[which(!is.na(mdata$value)),]
colnames(mdata) <- c("Software", "Year", "uIndex")
mdata$Year = as.numeric(as.character(mdata$Year))
mdata$uIndex = as.numeric(as.character(mdata$uIndex))
mdata$Software = as.character(mdata$Software)
# Plot static line plot
g <- ggplot(data=mdata, aes(x=Year, y=uIndex, col=Software)) + geom_line() + theme(legend.position="none")
# Plot interactive line plot
ggplotly(g)
