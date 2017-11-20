pollutantmean<-function(directory,pollutant,id=1:332){
    temp = NULL
    if(pollutant=="sulfate"){colp = 2}
    else if(pollutant == "nitrate"){colp = 3}
    for(i in id){
        Path = paste("/Users/meg116/datasciencecoursera/specdata/",str_pad(i,3,pad="0"),".csv",sep="")
        MyData <- read.csv(file=Path,header=TRUE,sep=",")
        temp = c(temp,MyData[,colp])
    }
    mean(temp,na.rm=TRUE)
}
#paste all together, then find mean