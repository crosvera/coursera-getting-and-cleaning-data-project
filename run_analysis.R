#!/usr/bin/env R

if (!file.exists("UCI HAR Dataset")) {
    print("UCI HAR Dataset directory not found, please download it and uzip it.")
    quit()
}

setwd("./UCI HAR Dataset/")

#
# 1. Merge the training and the test sets to create one data set.
#

features <- read.table('./features.txt', header=FALSE)
activities <- read.table("./activity_labels.txt", header=FALSE)

names(activities) <- c("activityId", "activityType")

#
## Tests
subjectTest <- read.table('./test/subject_test.txt', header=FALSE)
xTest <- read.table('./test/X_test.txt', header=FALSE)
yTest <- read.table('./test/y_test.txt', header=FALSE)

names(subjectTest) <- "subjectId"
names(yTest) <- "activityId"
names(xTest) <- features[[2]]

tests <- cbind(subjectTest, yTest, xTest)

#
## Train
subjectTrain <- read.table('./train/subject_train.txt', header=FALSE)
xTrain <- read.table('./train/X_train.txt', header=FALSE)
yTrain <- read.table('./train/y_train.txt', header=FALSE)

names(subjectTrain) <- "subjectId"
names(yTrain) <- "activityId"
names(xTrain) <- features[[2]]

train <- cbind(subjectTrain, yTrain, xTrain)

#
## Merge DataFrames
allData <- rbind(tests, train)


#
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement.
#
dataNames <- names(allData) 
mask <- c(grep("subjectId", dataNames) , grep("activityId", dataNames), grep("-mean\\(\\)..$", dataNames), grep("-std\\(\\)..$", dataNames))

finalData <- allData[mask]


#
# 3. Uses descriptive activity names to name the activities in the data set.
#

finalData <- merge(finalData, activities, by="activityId", all.x=TRUE)


#
# 4. Appropriately labels the data set with descriptive variable names.
#

labels <- names(finalData)
labels <- gsub("\\(\\)", "", labels)
labels <- gsub("-", "", labels)
labels <- gsub("std", "Std", labels)
labels <- gsub("mean", "Mean", labels)
labels <- gsub("^t", "time", labels)
labels <- gsub("^f", "freq", labels)

names(finalData) <- labels


#
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
#

tidyData <-  aggregate(finalData[,names(finalData) != c('activityId','subjectId', 'activityType')],by=list(subjectId = finalData$subjectId, activityType=finalData$activityType),mean)


#
## Export

write.table(tidyData, '../tidyData.txt',row.names=FALSE)
