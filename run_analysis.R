
#Method to Extract Mean and Standard Deviation
ExtractMeansandSD = function(datfram) {
  Ftrs <- read.table("UCI HAR dataset/features.txt")
  ColMean <-
    sapply(Ftrs[,2], function(x)
      grepl("mean()", x, fixed = T))
  ColStd <-
    sapply(Ftrs[,2], function(x)
      grepl("std()", x, fixed = T))
  extracteddataframe <- datfram[, (ColMean | ColStd)]
  colnames(extracteddataframe) <- Ftrs[(ColMean | ColStd), 2]
  extracteddataframe
}

#Import plyr library
library(plyr)


#Set working directory
setwd("D:/DataScience/Cleaning Data/Course Project/");
#Download the Zipped file and Unzip it
if (!file.exists("UCI HAR dataset")) {
  fileURL <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  zipfile = "UCI HAR dataset.zip"
  download.file(fileURL, destfile = zipfile)
  unzip(zipfile)
}

#Merge the Training and Test Data sets

#Training Set
Xtraining <- read.table("UCI HAR dataset/train/X_train.txt")
Ytraining <- read.table("UCI HAR dataset/train/y_train.txt")
SUBJtraining <- read.table("UCI HAR dataset/train/subject_train.txt")

#Test Set
Xtest  <- read.table("UCI HAR dataset/test/X_test.txt")
Ytest  <- read.table("UCI HAR dataset/test/y_test.txt")
SUBJtest <- read.table("UCI HAR dataset/test/subject_test.txt")

#Merge Data Sets
Xmerged <- rbind(Xtraining,  Xtest)
Ymerged <- rbind(Ytraining, Ytest)
SUBJmerged <- rbind(SUBJtraining, SUBJtest)

MergedDataSet <- list(x = Xmerged, y = Ymerged, subject = SUBJmerged)

# Extract Mean and Standard Deviation
XmeanSD <- ExtractMeansandSD(MergedDataSet$x)

# Name the activities
MergedY <- MergedDataSet$y
colnames(MergedY) <- "activity"
MergedY$activity[MergedY$activity == 1] = "WALKING"
MergedY$activity[MergedY$activity == 2] = "WALKING_UPSTAIRS"
MergedY$activity[MergedY$activity == 3] = "WALKING_DOWNSTAIRS"
MergedY$activity[MergedY$activity == 4] = "SITTING"
MergedY$activity[MergedY$activity == 5] = "STANDING"
MergedY$activity[MergedY$activity == 6] = "LAYING"


#Use Appropriate Description for Subject
colnames(MergedDataSet$subject) <- c("subject")

#Combine the Results
CombinedDs <-  cbind(XmeanSD, MergedY, MergedDataSet$subject)

#For each subset of the input data frame, apply function then combine results into a data frame.
cleanedDS <-
  ddply(CombinedDs, .(subject, activity), function(x)
    colMeans(x[,1:60]))

#Write the cleaned dataset to a text file
write.table(cleanedDS, "UCI_Averages_After_CleanUp.txt",row.name=FALSE)



