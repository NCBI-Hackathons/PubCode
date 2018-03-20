nPapers = 10
citeDF = list() 

for (i in 1:nPapers){
  nYears = sample(5:10, 1, replace=T)
  currSample = sort(sample(0:100, nYears, replace=T))
  if (i%%2==0){
    currSample = sort(currSample, decreasing = TRUE)
  }
  citeDF[[paste0("Paper", i)]] = currSample
}



##########
First <- c(71.54,76.48,77.58,63.80,66.16,73.22,70.71,72.94,73.22,69.37,70.49,72.25,70.94)

Second <- c(80.61,79.03,80.35,77.52,79.16,80.80,80.49,82.00,83.16,84.15,80.16,84.30,84.01,80.81,81.69,82.79,81.41,80.45,79.85,79.81,84.70,85.22,80.51,82.39,83.43,82.39,81.91,81.89,82.00,82.14,83.30,74.11)

a2 <- data.frame(Seq=seq(0, (length(First) - 1) * 3, by = 3), All=First)
a4 <- data.frame(Seq=seq(0, (length(Second) - 1) * 3, by = 3), All=Second)

sg <- rbind(a2,a4)
sg$Legend <- c(rep("First", nrow(a2)), rep("Second", nrow(a4)))
ggplot(data=sg, aes(x=Seq, y=All, col=Legend)) + geom_line()
  