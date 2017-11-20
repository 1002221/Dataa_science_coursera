complete<-function(directory,id=1:332){
    id1=NULL
    nobs=NULL
    for(i in id){
        Path = paste("/Users/meg116/datasciencecoursera/specdata/",str_pad(i,3,pad="0"),".csv",sep="")
        MyData <- read.csv(file=Path,header=TRUE,sep=",")
        id1 = c(id1,i)
        nobs = c(nobs,dim(subset(MyData,(!is.na(MyData[,2]))&(!is.na(MyData[,3]))))[1])
    }
    id=id1
    data.frame(id,nobs)
}
#paste all together, then find mean