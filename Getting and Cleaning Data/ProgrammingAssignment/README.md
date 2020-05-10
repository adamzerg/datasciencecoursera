The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

### Review criteria

The submitted data set is tidy.
The Github repo contains the required scripts.
GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
The README that explains the analysis files is clear and understandable.
The work submitted for this project is the work of the student who submitted it.

### Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit:

1.  A tidy data set as described below
2.  A link to a Github repository with your script for performing the analysis
3.  A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.

You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

####You should create one R script called run_analysis.R that does the following:

Merges the training and the test sets to create one data set.

1.  Extracts only the measurements on the mean and standard deviation for each measurement
2.  Uses descriptive activity names to name the activities in the data set
3.  Appropriately labels the data set with descriptive variable names
4.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

Good luck!


## Steps taken below

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
Use cbind and rbind for data mergence of train vs test

#### 5. Appropriately labels the data set with descriptive variable names
Extracting lables out from feature.txt, complete description for each variable
Remove symbols such like , - and ()
Assign for column names to each data set

#### 6. Extracts only the measurements on the mean and standard deviation for each measurement
Look up column names in measurement, so only keep the measures of mean and std

#### 7. Uses descriptive activity names to name the activities in the data set
Read activity labels from txt to the combined data set

#### 8. Creates an independent tidy data set with the average of each variable for each activity and each subject
Use two methods here for aggregations: melt + dcast / ddply
Either methods create same tidy_data txt result for cross checking.