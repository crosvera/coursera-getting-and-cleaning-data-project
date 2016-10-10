# Getting and Cleaning Data Project
By Carlos Ríos

## What you find here

- `run_analysis.R`: An R script to extract and summarize the *Human Activity Recognition Using Smartphones Data Set*
- `tidyData.txt`: The summarized data as a tidy data file
- `codebook.md`: Code Book
- `README.md`: This file


## How to make it work

1 - Get the data, download from:
   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2 - Unzip it

3 - Run the R script:
   `R -f run_analysis.R`

4 - Profit!


## What `run_analysis.R` does?
1 - Merges the training and the test sets to create one data set.
2 - Extracts only the measurements on the mean and standard deviation for each measurement.
3 - Uses descriptive activity names to name the activities in the data set
4 - Appropriately labels the data set with descriptive variable names.
5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
