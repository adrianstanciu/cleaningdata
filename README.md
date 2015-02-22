#Getting and Cleaning Data - Course Project

The code file run_analysis.R is an example of how to prepare a tidy dataset that can be used for analysis.

Steps:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each
measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set
with the average of each variable for each activity and each subject.

Please refer to CodeBook.md for further details.

Before running, please manually set working directory to the location of the source file and ensure the test data is in a sub-folder called "UCI_HAR_Dataset"

The function to be called is createTidyData().