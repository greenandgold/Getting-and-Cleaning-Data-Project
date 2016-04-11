# download the zip file and put it in the GCD (Getting and Cleaning Data) directory
if(!file.exists("GCD")){dir.create("GCD")}
temp <- tempfile()
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, temp)
unzip(temp, exdir="GCD")
unlink(temp)

# change to GCD directory
setwd("GCD")

# load libraries
library(reshape2)

# features 
features <- read.table("UCI HAR Dataset/features.txt")
featurescol <- as.character(features[,2])

# extract the mean and standard deviation measurements
MeanStdFeaturesIndices <- grep("mean|std", featurescol)
MeanStdFeaturesNames <- features[MeanStdFeaturesIndices,2]

# tidy the features names
MeanStdFeaturesNames <- gsub("()", "", MeanStdFeaturesNames, fixed = TRUE)
MeanStdFeaturesNames <- gsub("-", "", MeanStdFeaturesNames, fixed = TRUE)
MeanStdFeaturesNames <- gsub("std", "Std", MeanStdFeaturesNames, fixed = TRUE)
MeanStdFeaturesNames <- gsub("mean", "Mean", MeanStdFeaturesNames, fixed = TRUE)

# activities, with descriptive activity names
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
ActivitiesLevels <- activities[,1]
ActivitiesNames <- as.character(activities[,2])


# test data
TestSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
TestActivities <- read.table("./UCI HAR Dataset/test/y_test.txt")
TestMeasurements <- read.table("./UCI HAR Dataset/test/X_test.txt")[MeanStdFeaturesIndices]
Test <- cbind(TestSubjects, TestActivities, TestMeasurements)

# train data
TrainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
TrainActivities <- read.table("./UCI HAR Dataset/train/y_train.txt")
TrainMeasurements <- read.table("UCI HAR Dataset/train/X_train.txt")[MeanStdFeaturesIndices]
Train <- cbind(TrainSubjects, TrainActivities, TrainMeasurements)

# merge the training and test sets
MergeTestTrain <- rbind(Test, Train)

# use descriptive variable names
names(MergeTestTrain) <- c("subject", "activity", MeanStdFeaturesNames)

# convert subject and activity to factors
MergeTestTrain$subject <- as.factor(MergeTestTrain$subject)
MergeTestTrain$activity <- factor(MergeTestTrain$activity, levels = ActivitiesLevels, labels = ActivitiesNames)

# reshape 
Melt <- melt(MergeTestTrain, id = c("subject", "activity"))

# average of each variable for each activity and each subject
Means <- dcast(Melt, subject + activity ~ variable, mean)

# write to file
write.table(Means, "averages.txt", row.names = FALSE, quote = FALSE)

