pollutantmean<-function(directory,pollutant,id=1){
    Path = paste("/Users/meg116/datasciencecoursera/specdata/",str_pad(1,3,pad="0"),".csv",sep="")
    MyData <- read.csv(file=Path)
    mean(MyData$pollutant,na.rm=TRUE)
}