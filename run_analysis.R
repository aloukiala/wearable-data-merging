# setwd("/home/antti/Desktop/GCData/project/UCI HAR Dataset")
# Working directory should contain the Samsung data
# All needed files
files <- c("features.txt", "train/X_train.txt", "train/X_train.txt", 
           "train/subject_train.txt", "test/X_test.txt", "test/y_test.txt",
           "test/subject_test.txt", "activity_labels.txt")
if (!all(files %in% list.files(recursive=T))) {
  print("Not all files are found in current directory! Check working directory")
}
features <- read.table("features.txt", header=F, stringsAsFactors =T)
# Get the train data
train <- read.table("train/X_train.txt", header=F, col.names=features[,2],  check.names=F)
# Add activity and subject at this point so they are added to right data set
train$activityId <- read.table("train/y_train.txt", header=F, col.names="activity")$activity
train$subject <- read.table("train/subject_train.txt", header=F, col.names="subject")$subject

# Get the test data
test <- read.table("test/X_test.txt", header=F, col.names=features[,2], check.names=F)
# Add activity and subject at this point so they are added to right data set
test$activityId <- read.table("test/y_test.txt", header=F, col.names="activity")$activity
test$subject <- read.table("test/subject_test.txt", header=F, col.names="subject")$subject
# Change the test row names so that they do not overlap
row.names(test) <- (nrow(train)+1):(nrow(test)+nrow(train))
# Combine the train data to test data to make one data set
data <- rbind(train, test)
# Remove the old data sets so that they dont eat memory
rm(train)
rm(test)

# Extract only mean and std data
# mean columns
meanCol <- features[grepl("mean()", features[,2], fixed=T),1]
# std columns
stdCol <- features[grepl("std()", features[,2], fixed=T),1]
# Columns to pick, mean, std, subject and activity
cols <- c(meanCol, stdCol, 562, 563)
data <- data[,cols]

# Label the data with descriptive activity names
activityLabel <- read.table("activity_labels.txt", header=F, stringsAsFactors =T, col.names=c("id", "activity"))
# merge the activity label
data <- merge(data, activityLabel, by.x="activityId", by.y="id")
# remove the activityId
data <- data[,-(match("activityId", names(data)))]

# With dplyr the grouping is straight forward
require("dplyr")
library(dplyr)
dataGroup <- group_by(data, activity, subject)
result <- summarise_each(dataGroup, funs(mean(., na.rm = TRUE)))

# Write the tidy data into a file
write.table(result, file="tidy_data.txt", row.name=F)
print("Tidy data writen into a file in working directory called tidy_data.txt")