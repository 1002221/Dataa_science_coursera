setwd("/Users/meg116/datasciencecoursera/UCI HAR Dataset")

library(matrixStats)
library(dplyr)

#import features and activity labels
features<-(read.table("./features.txt",colClasses=c("numeric","character")))
activity_labels<-(read.table("./activity_labels.txt"))

#combined the test and train sets
readin<- function(path){
    return(rbind(read.table(paste("./train/",path,"_train.txt",sep=""),colClasses="numeric"),
                 read.table(paste("./test/",path,"_test.txt",sep=""),colClasses="numeric")))
}

#work out the mean and standard deviation of rows, then keep only those columns
mean_std<- function(df){
    df$mean<-rowMeans(df)
    df$std<-rowSds(as.matrix(df))
    df<-df%>%select(mean,std)
    colnames(df)<-c(paste(comment(df),"_mean",sep=""),paste(comment(df),"_std",sep=""))
    return(df)
}

#read in data, collating test and train sets for each variable
subject<-readin("subject")
colnames(subject)<-"Subject"
X<-readin("X")
y<-readin("y")
body_acc_x<-readin("Inertial Signals/body_acc_x")
body_acc_y<-readin("Inertial Signals/body_acc_y")
body_acc_z<-readin("Inertial Signals/body_acc_z")
body_gyro_x<-readin("Inertial Signals/body_gyro_x")
body_gyro_y<-readin("Inertial Signals/body_gyro_y")
body_gyro_z<-readin("Inertial Signals/body_gyro_z")
total_acc_x<-readin("Inertial Signals/total_acc_x")
total_acc_y<-readin("Inertial Signals/total_acc_y")
total_acc_z<-readin("Inertial Signals/total_acc_z")
comment(body_acc_x)<-"body_acc_x"
comment(body_acc_y)<-"body_acc_y"
comment(body_acc_z)<-"body_acc_z"
comment(body_gyro_x)<-"body_gyro_x"
comment(body_gyro_y)<-"body_gyro_y"
comment(body_gyro_z)<-"body_gyro_z"
comment(total_acc_x)<-"total_acc_x"
comment(total_acc_y)<-"total_acc_y"
comment(total_acc_z)<-"total_acc_z"
body_acc_x<-mean_std(body_acc_x)
body_acc_y<-mean_std(body_acc_y)
body_acc_z<-mean_std(body_acc_z)
body_gyro_x<-mean_std(body_gyro_x)
body_gyro_y<-mean_std(body_gyro_y)
body_gyro_z<-mean_std(body_gyro_z)
total_acc_x<-mean_std(total_acc_x)
total_acc_y<-mean_std(total_acc_y)
total_acc_z<-mean_std(total_acc_z)

#choose only features with mean or std dev
features<-features[grepl("mean",features$V2)|grepl("std",features$V2),]

#only keep those features in X
X<-X[,features$V1]

#give variables descriptive names
colnames(X)<-features$V2

#give descriptive names to the activities
y<-y%>%mutate(activity_label=(activity_labels$V2)[V1])%>%select(activity_label)

#join all the data together (step 4)
final1<-cbind(subject,X,y,body_acc_x,
      body_acc_y,
      body_acc_z,
      body_gyro_x,
      body_gyro_y,
      body_gyro_z,
      total_acc_x,
      total_acc_y,
      total_acc_z)

#only select the variables corresponding to means (step 5)
final2<-final1[,grepl("mean",names(final1))]

write.table(final2, "./mydata.txt",row.name=FALSE, sep="\t")
