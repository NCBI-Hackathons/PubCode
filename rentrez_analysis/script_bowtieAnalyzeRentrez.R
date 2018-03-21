# script: assess by-year citation rates of an aligner (bowtie/bowtie2) in a research space (RNA-seq)

library(rentrez)

# function to grab by-year citations
search_year <- function(year, term){
  query <- paste(term, "AND (", year, "[PDAT])")
  entrez_search(db="pubmed", term=query, retmax=0)$count
}

year <- 2008:2017; 
papers.bowtie <- sapply(year, search_year, term="bowtie", USE.NAMES=FALSE)
papers.bowtie2 <- sapply(year, search_year, term="bowtie2", USE.NAMES=FALSE)
papers.rnaseq <- sapply(year, search_year, term="RNA-seq|RNAseq|RNA sequencing", USE.NAMES=FALSE)

# line and dot plots of citation counts, by year
par(mfrow=c(3,1))
plot(year, papers.bowtie, type='b', main="Bowtie",ylab="Citations (N)")
plot(year, papers.bowtie2, type='b', main="Bowtie2",ylab="Citations (N)")
plot(year, papers.rnaseq, type='b', main="RNA-seq|RNAseq|RNA sequencing",ylab="Citations (N)")

# barplot of normalized citation frequencies, by year
dev.off()
barplot(t(matrix(c(1000*(papers.bowtie/papers.rnaseq),
                   1000*(papers.bowtie2/papers.rnaseq)),nrow=10)),
        beside = T, col=c("red","blue"),
        names.arg=as.character(seq(2008,2017,1)),xlab="Year",
        ylab="1000 * aligner / RNAseq (citations)",las=2)
legend("topleft",legend=c("bowtie","bowtie2"),
       cex=0.8,fill=c("red","blue"),bty="n")