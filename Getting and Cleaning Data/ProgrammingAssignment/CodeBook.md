## Codebook

#### 1. Download source data
Preparation including sourcing library, download data file, unzip the data files

#### 2. Load Data
Load data with read.table function here including 3 sets of train vs test data and the labels of activity and feature measures:

subject_test, subject_train, 
X_test, X_train,
y_test, y_train

activity_labels
features

#### 3. Explore number of rows in each data set
Use nrow here to ensure number of rows are matched before the data mergence

#### 4. Merge training and the test sets
Use rbind to for data mergence of train vs test

#### 5. Appropriately labels the data set with descriptive variable names
Extracting lables out from feature.txt, complete description for each variable
Remove symbols such like , - and ()
Assign for column names to each data set

#### 6. Extracts only the measurements on the mean and standard deviation for each measurement
Look up column names in measurement, so only keep the measures of mean and std

#### 7. Uses descriptive activity names to name the activities in the data set
Read activity labels from txt before cbind the 3 data sets

#### 8. Creates an independent tidy data set with the average of each variable for each activity and each subject
Use two methods here for aggregations: melt + dcast / ddply
Either methods create same tidy_data txt result for cross checking.