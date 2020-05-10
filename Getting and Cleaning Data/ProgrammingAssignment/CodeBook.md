
## Data Sources
Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws


## Source Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 


## Source File

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


## Feature Measures

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean


## Tidy output measures

 [1] "subject_id"                                              
 [2] "activity_id"                                             
 [3] "activity"                                                
 [4] "TimeBodyAccelerationMeanX"                               
 [5] "TimeBodyAccelerationMeanY"                               
 [6] "TimeBodyAccelerationMeanZ"                               
 [7] "TimeBodyAccelerationStdX"                                
 [8] "TimeBodyAccelerationStdY"                                
 [9] "TimeBodyAccelerationStdZ"                                
[10] "TimeGravityAccelerationMeanX"                            
[11] "TimeGravityAccelerationMeanY"                            
[12] "TimeGravityAccelerationMeanZ"                            
[13] "TimeGravityAccelerationStdX"                             
[14] "TimeGravityAccelerationStdY"                             
[15] "TimeGravityAccelerationStdZ"                             
[16] "TimeBodyAccelerationJerkMeanX"                           
[17] "TimeBodyAccelerationJerkMeanY"                           
[18] "TimeBodyAccelerationJerkMeanZ"                           
[19] "TimeBodyAccelerationJerkStdX"                            
[20] "TimeBodyAccelerationJerkStdY"                            
[21] "TimeBodyAccelerationJerkStdZ"                            
[22] "TimeBodyGyroMeanX"                                       
[23] "TimeBodyGyroMeanY"                                       
[24] "TimeBodyGyroMeanZ"                                       
[25] "TimeBodyGyroStdX"                                        
[26] "TimeBodyGyroStdY"                                        
[27] "TimeBodyGyroStdZ"                                        
[28] "TimeBodyGyroJerkMeanX"                                   
[29] "TimeBodyGyroJerkMeanY"                                   
[30] "TimeBodyGyroJerkMeanZ"                                   
[31] "TimeBodyGyroJerkStdX"                                    
[32] "TimeBodyGyroJerkStdY"                                    
[33] "TimeBodyGyroJerkStdZ"                                    
[34] "TimeBodyAccelerationMagnitudeMean"                       
[35] "TimeBodyAccelerationMagnitudeStd"                        
[36] "TimeGravityAccelerationMagnitudeMean"                    
[37] "TimeGravityAccelerationMagnitudeStd"                     
[38] "TimeBodyAccelerationJerkMagnitudeMean"                   
[39] "TimeBodyAccelerationJerkMagnitudeStd"                    
[40] "TimeBodyGyroMagnitudeMean"                               
[41] "TimeBodyGyroMagnitudeStd"                                
[42] "TimeBodyGyroJerkMagnitudeMean"                           
[43] "TimeBodyGyroJerkMagnitudeStd"                            
[44] "FrequencyuencyBodyAccelerationMeanX"                     
[45] "FrequencyuencyBodyAccelerationMeanY"                     
[46] "FrequencyuencyBodyAccelerationMeanZ"                     
[47] "FrequencyuencyBodyAccelerationStdX"                      
[48] "FrequencyuencyBodyAccelerationStdY"                      
[49] "FrequencyuencyBodyAccelerationStdZ"                      
[50] "FrequencyuencyBodyAccelerationMeanFrequencyX"            
[51] "FrequencyuencyBodyAccelerationMeanFrequencyY"            
[52] "FrequencyuencyBodyAccelerationMeanFrequencyZ"            
[53] "FrequencyuencyBodyAccelerationJerkMeanX"                 
[54] "FrequencyuencyBodyAccelerationJerkMeanY"                 
[55] "FrequencyuencyBodyAccelerationJerkMeanZ"                 
[56] "FrequencyuencyBodyAccelerationJerkStdX"                  
[57] "FrequencyuencyBodyAccelerationJerkStdY"                  
[58] "FrequencyuencyBodyAccelerationJerkStdZ"                  
[59] "FrequencyuencyBodyAccelerationJerkMeanFrequencyX"        
[60] "FrequencyuencyBodyAccelerationJerkMeanFrequencyY"        
[61] "FrequencyuencyBodyAccelerationJerkMeanFrequencyZ"        
[62] "FrequencyuencyBodyGyroMeanX"                             
[63] "FrequencyuencyBodyGyroMeanY"                             
[64] "FrequencyuencyBodyGyroMeanZ"                             
[65] "FrequencyuencyBodyGyroStdX"                              
[66] "FrequencyuencyBodyGyroStdY"                              
[67] "FrequencyuencyBodyGyroStdZ"                              
[68] "FrequencyuencyBodyGyroMeanFrequencyX"                    
[69] "FrequencyuencyBodyGyroMeanFrequencyY"                    
[70] "FrequencyuencyBodyGyroMeanFrequencyZ"                    
[71] "FrequencyuencyBodyAccelerationMagnitudeMean"             
[72] "FrequencyuencyBodyAccelerationMagnitudeStd"              
[73] "FrequencyuencyBodyAccelerationMagnitudeMeanFrequency"    
[74] "FrequencyuencyBodyAccelerationJerkMagnitudeMean"         
[75] "FrequencyuencyBodyAccelerationJerkMagnitudeStd"          
[76] "FrequencyuencyBodyAccelerationJerkMagnitudeMeanFrequency"
[77] "FrequencyuencyBodyGyroMagnitudeMean"                     
[78] "FrequencyuencyBodyGyroMagnitudeStd"                      
[79] "FrequencyuencyBodyGyroMagnitudeMeanFrequency"            
[80] "FrequencyuencyBodyGyroJerkMagnitudeMean"                 
[81] "FrequencyuencyBodyGyroJerkMagnitudeStd"                  
[82] "FrequencyuencyBodyGyroJerkMagnitudeMeanFrequency"        
[83] "AngletBodyAccelerationMeanGravity"                       
[84] "AngletBodyAccelerationJerkMeanGravityMean"               
[85] "AngletBodyGyroMeanGravityMean"                           
[86] "AngletBodyGyroJerkMeanGravityMean"                       
[87] "AngleXGravityMean"                                       
[88] "AngleYGravityMean"                                       
[89] "AngleZGravityMean"



## Transformation

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