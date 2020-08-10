#### Preparation ####

setwd("~/R/ArquivosR/prova_aula_4")

download.file(
        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
        "HumanActivityRecognition.zip")
unzip("HumanActivityRecognition.zip", exdir = "HumanActivityRecognition")
unlink( "HumanActivityRecognition.zip")

#### 1. Merges the training and the test sets to create one data set ####

# 1.1. Reads tables and adds column names for test data
test_subject <- read.table(
        "HumanActivityRecognition/UCI HAR Dataset/test/subject_test.txt", 
        header = FALSE)
colnames(test_subject) <- "subject"

test_activities <- read.table(
        "HumanActivityRecognition/UCI HAR Dataset/test/y_test.txt", 
        header = FALSE)
colnames(test_activities) <- "activity"

test_measures <- read.table(
        "HumanActivityRecognition/UCI HAR Dataset/test/x_test.txt", 
        header = FALSE)
colnames(test_measures) <- readLines("HumanActivityRecognition/UCI HAR Dataset/features.txt")

# 1.2. Reads tables and adds column names for train data
train_subject <- read.table(
        "HumanActivityRecognition/UCI HAR Dataset/train/subject_train.txt", 
                            header = FALSE)
colnames(train_subject) <- "subject"

train_activities <- read.table(
        "HumanActivityRecognition/UCI HAR Dataset/train/y_train.txt", 
        header = FALSE)
colnames(train_activities) <- "activity"

train_measures <- read.table(
        "HumanActivityRecognition/UCI HAR Dataset/train/x_train.txt", 
        header = FALSE)
colnames(train_measures) <- readLines("HumanActivityRecognition/UCI HAR Dataset/features.txt")

# 1.3.Merges datasets

#Merges subjects, labels, and measures for test and train sets
test <- cbind(test_subject, test_activities, test_measures)
train <- cbind(train_subject, train_activities, train_measures)

#Merges test and train sets
full_data <- rbind(test, train)


#### 2. Extracts only the measurements on the mean and standard deviation for each measurement ####

mean_std <- grep(".*Mean.*|.*Std.*", names(full_data), ignore.case = TRUE)
full_data <- full_data[, c(1, 2, mean_std)]

#### 3. Uses descriptive activity names to name the activities in the data set ####

full_data$activity <- as.character(full_data$activity)

full_data$activity <- gsub("1", "walking", full_data$activity)
full_data$activity <- gsub("2", "walking_upstairs", full_data$activity)
full_data$activity <- gsub("3", "walking_downstairs", full_data$activity)
full_data$activity <- gsub("4", "sitting", full_data$activity)
full_data$activity <- gsub("5", "standing", full_data$activity)
full_data$activity <- gsub("6", "laying", full_data$activity)

full_data$activity <- as.factor(full_data$activity)

#### 4. Appropriately labels the data set with descriptive variable names ####

variables <- colnames(full_data)

variables <- gsub(".*? ", "", variables)
variables <- gsub("Acc", "Accelerometer", variables)
variables <- gsub("BodyBody", "Body", variables)
variables <- gsub("Gyro", "Gyroscope", variables)
variables <- gsub("Mag", "Magnitude", variables)
variables <- gsub("Mean\\()", "Mean", variables)
variables <- gsub("Freq\\()", "Frequency", variables)
variables <- gsub("Frequency\\()", "Frequency", variables)
variables <- gsub("STD\\()", "STD", variables)
variables <- gsub("^f", "Frequency", variables)
variables <- gsub("^t", "Time", variables)

colnames(full_data) <- variables

#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. ####

full_data$subject <- as.factor(full_data$subject)

independent <- aggregate(. ~subject + activity, full_data, mean)
independent <- independent[order(independent$subject, independent$activity), ]

write.table(independent, "independent.txt", row.names = FALSE)