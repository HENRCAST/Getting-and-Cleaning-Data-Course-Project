# Getting and Cleaning Data Course Project

This is the required projected for the Getting and Cleaning Data Course available at Coursera.
It contains an RScript written for getting and cleaning (surprise!) data sets available at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It performs the following tasks:

1. Downloading the files from the link above, unziping them to a new directory, and deleting the .zip file.
2. Reading and merging all datasets into a single one, while adding descriptive variable names.
  - The names for the measurements documented in the "x_test.txt" and "x_train.txt" are taken from the "features.txt" file
3. Remove a series of measurements, keeping only on those the mean and standard deviation for each measurement.
  - It does so by searching for the columns that include the text patterns "Mean" and "Std" and extracting them from the full data set.
  - It keeps the columns "subject" and "activity".
4. Substituting values from the "activity" variable, which indices, with descriptive names.
  - "1" is replaced by "walking".
  - "2" is replaced by "walking_upstairs".
  - "3" is replaced by "walking_downstairs".
  - "4" is replaced by "sitting".
  - "5" is replaced by "standing".
  - "6" is replaced by "laying".
5. Renaming labels used for measurements so that they have more descriptive names.
  - It does so by replacing certain text patterns for others.
 - For example, "Acc" becomes "Accelerometer"
6. Generating a new data set that with the average of each variable for each activity and each subject.
7. Saving the new dataset to "independent.txt".
