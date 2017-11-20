corr<-function(directory,threshold=0){
    correlations=NULL
    for(i in 1:332){
        Path = paste("/Users/meg116/datasciencecoursera/specdata/",str_pad(i,3,pad="0"),".csv",sep="")
        MyData <- read.csv(file=Path,header=TRUE,sep=",")
        if(dim(subset(MyData,(!is.na(MyData[,2]))&(!is.na(MyData[,3]))))[1]>threshold)
        correlations<-c(correlations,cor(MyData[,2],MyData[,3],use="complete.obs"))
    }
    if(is.null(correlations))
        result<-numeric(1)
    correlations
}
#paste all together, then find mean