## Getting and Cleaning Data Course Project
## Prepares a tidy dataset that can be used for later analysis

## Steps:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each
## measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.

## Before running, please manually set working directory
## to the location of this source file
## and ensure the test data is in a sub-folder called "UCI_HAR_Dataset"


## Reads the training and test sets, merges them, adds columns for activity 
## and subject, and writes the result to disk the result in table format
createTidyData <- function () {
  
    #read the files
    X_train <- read.table('UCI_HAR_Dataset/train/X_train.txt')
    X_test <- read.table('UCI_HAR_Dataset/test/X_test.txt')
    
    # merge the training and test sets rows
    dataset <- rbind(X_train, X_test)
    
    # transpose the 2nd column of the features to get headers names
    features <- read.table('UCI_HAR_Dataset/features.txt')
    headers <- t(features[, 2])
    
    # apply header names to dataset
    colnames(dataset) <- headers
    
    # get indices of columns containing mean data
    meanIndices <- grepl(("mean()"), names(dataset), fixed = TRUE)
    datasetMeanCols <- dataset[, meanIndices]
    
    # get indices of columns containing std data
    stdIndices <- grepl(("std()"), names(dataset), fixed = TRUE)
    datasetStdCols <- dataset[, stdIndices]
    
    # step 2 - extract only measurements related to mean and standard deviation
    datasetExtract <- cbind(datasetMeanCols, datasetStdCols)
    
    #add the subject and activity to the dataset
    y_train <- read.table('UCI_HAR_Dataset/train/y_train.txt')
    subject_train <- read.table('UCI_HAR_Dataset/train/subject_train.txt')
    y_test <- read.table('UCI_HAR_Dataset/test/y_test.txt')
    subject_test <- read.table('UCI_HAR_Dataset/test/subject_test.txt')
    
    activity <- rbind(y_train, y_test)
    subject <- rbind(subject_train, subject_test)
    
    datasetExtract <- cbind(c(subject, activity), datasetExtract)
    colnames(datasetExtract)[1] <- "subject"
    colnames(datasetExtract)[2] <- "activity"
    
    activities <- read.table('UCI_HAR_Dataset/activity_labels.txt',
        col.names = c("number","name"))
    datasetExtract$activity <- factor(datasetExtract$activity,
        activities$number, activities$name)
    
    # calculates the average of each variable for each activity and each subject
    tidyData <- aggregate(.~activity + subject, datasetExtract, mean)
    
    # store tidy data
    write.table(tidyData, file="tidy_data.txt", row.name = FALSE)
}
