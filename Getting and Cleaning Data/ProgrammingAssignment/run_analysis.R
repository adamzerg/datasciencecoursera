# install.packages("dplyr")
# install.packages("plyr")
# install.packages("tidyr")

library(dplyr)
library(plyr)
library(reshape2)

## 1. Download source data

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
              , 'HAR.zip'
              , method='curl' )

unzip("HAR.zip", files = NULL, exdir=".")
getwd()
dir()


## 2. Load Data

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")


## 3. Explore number of rows in each data set

nrow(subject_test)
nrow(subject_train)
nrow(X_test)
nrow(X_train)
nrow(y_test)
nrow(y_train)
nrow(activity_labels)
nrow(features)


## 4. Merge training and the test sets

measure_train <- cbind(subject_train, y_train, X_train)
measure_test <- cbind(subject_test, y_test, X_test)
measurement <- rbind(measure_train, measure_test)


## 5. Appropriately labels the data set with descriptive variable names

feature_label <- features[, 2]
feature_label <- gsub("^t", "Time", feature_label)
feature_label <- gsub("^f", "Frequency", feature_label)
feature_label <- gsub("BodyBody", "Body", feature_label)
feature_label <- gsub("mean", "Mean", feature_label)
feature_label <- gsub("std", "Std", feature_label)
feature_label <- gsub("Acc", "Acceleration", feature_label)
feature_label <- gsub("Freq", "Frequency", feature_label)
feature_label <- gsub("Mag", "Magnitude", feature_label)
feature_label <- gsub("angle", "Angle", feature_label)
feature_label <- gsub("gravity", "Gravity", feature_label)
feature_label <- gsub(",|-|\\(|\\)", "", feature_label)

colnames(measurement) <- c('subject_id','activity_id',feature_label)
colnames(activity_labels) <- c('activity_id','activity')


## 6. Extracts only the measurements on the mean and standard deviation for each measurement

measurement <- measurement[, grep("subject_id|activity_id|Mean|Std", colnames(measurement))]
colnames(measurement)


## 7. Uses descriptive activity names to name the activities in the data set

measurement <- merge(activity_labels, measurement)
nrow(subject)
nrow(activity)
nrow(measurement)



## 8. Creates an independent tidy data set with the average of each variable for each activity and each subject

column_labels = colnames(measurement[1:3])
row_labels = colnames(measurement[4:ncol(measurement)])
normalize_measure = melt(measurement, id = column_labels, measure.vars = row_labels)
tidy_data = dcast(normalize_measure, activity_id + activity + subject_id~ variable, mean)

tidy_data_arrange <- tidy_data[c(3,2,4:ncol(tidy_data))]
write.table(arrange(tidy_data_arrange, subject_id), file = "./tidy_data.txt", row.names = FALSE)

#group_by(measurement, subject_id, activity)
tidy_data2 <- ddply(measurement, column_labels, numcolwise(mean))
write.table(tidy_data2, file = "./tidy_data2.txt", row.names = FALSE)
