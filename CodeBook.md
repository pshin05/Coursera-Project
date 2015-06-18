## Coursera - Getting and Cleaning Data Project

### Introduction
The data set contained in "averages.txt" originates from the "recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors". The raw data from the experiment were collected and made available at [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The tidy data contained in "averages.txt" is a summary of the raw data downloaded from this UCI web site. In particular, it gives the calculated means for all features in the raw data set (see below for detail) for each subject and activities.

### Data Set Information
The following is an excerpt from the description of the experiment on [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones):

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
> Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
> wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope,
> we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.
> The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly
> partitioned into two sets, where 70% of the volunteers was selected for generating the training data
> and 30% the test data. 

The tidy 


|[1] "subject"                   |           "activity"                   |          "tBodyAcc-mean()-X"|
|[4] "tBodyAcc-mean()-Y"         |           "tBodyAcc-mean()-Z"         |           "tBodyAcc-std()-X"|


[7] "tBodyAcc-std()-Y"                     "tBodyAcc-std()-Z"                     "tGravityAcc-mean()-X"
[10] "tGravityAcc-mean()-Y"                 "tGravityAcc-mean()-Z"                 "tGravityAcc-std()-X"
[13] "tGravityAcc-std()-Y"                  "tGravityAcc-std()-Z"                  "tBodyAccJerk-mean()-X"
[16] "tBodyAccJerk-mean()-Y"                "tBodyAccJerk-mean()-Z"                "tBodyAccJerk-std()-X"
[19] "tBodyAccJerk-std()-Y"                 "tBodyAccJerk-std()-Z"                 "tBodyGyro-mean()-X"
[22] "tBodyGyro-mean()-Y"                   "tBodyGyro-mean()-Z"                   "tBodyGyro-std()-X"
[25] "tBodyGyro-std()-Y"                    "tBodyGyro-std()-Z"                    "tBodyGyroJerk-mean()-X"
[28] "tBodyGyroJerk-mean()-Y"               "tBodyGyroJerk-mean()-Z"               "tBodyGyroJerk-std()-X"
[31] "tBodyGyroJerk-std()-Y"                "tBodyGyroJerk-std()-Z"                "tBodyAccMag-mean()"
[34] "tBodyAccMag-std()"                    "tGravityAccMag-mean()"                "tGravityAccMag-std()"
[37] "tBodyAccJerkMag-mean()"               "tBodyAccJerkMag-std()"                "tBodyGyroMag-mean()"
[40] "tBodyGyroMag-std()"                   "tBodyGyroJerkMag-mean()"              "tBodyGyroJerkMag-std()"
[43] "fBodyAcc-mean()-X"                    "fBodyAcc-mean()-Y"                    "fBodyAcc-mean()-Z"
[46] "fBodyAcc-std()-X"                     "fBodyAcc-std()-Y"                     "fBodyAcc-std()-Z"
[49] "fBodyAcc-meanFreq()-X"                "fBodyAcc-meanFreq()-Y"                "fBodyAcc-meanFreq()-Z"
[52] "fBodyAccJerk-mean()-X"                "fBodyAccJerk-mean()-Y"                "fBodyAccJerk-mean()-Z"
[55] "fBodyAccJerk-std()-X"                 "fBodyAccJerk-std()-Y"                 "fBodyAccJerk-std()-Z"
[58] "fBodyAccJerk-meanFreq()-X"            "fBodyAccJerk-meanFreq()-Y"            "fBodyAccJerk-meanFreq()-Z"
[61] "fBodyGyro-mean()-X"                   "fBodyGyro-mean()-Y"                   "fBodyGyro-mean()-Z"
[64] "fBodyGyro-std()-X"                    "fBodyGyro-std()-Y"                    "fBodyGyro-std()-Z"
[67] "fBodyGyro-meanFreq()-X"               "fBodyGyro-meanFreq()-Y"               "fBodyGyro-meanFreq()-Z"
[70] "fBodyAccMag-mean()"                   "fBodyAccMag-std()"                    "fBodyAccMag-meanFreq()"
[73] "fBodyBodyAccJerkMag-mean()"           "fBodyBodyAccJerkMag-std()"            "fBodyBodyAccJerkMag-meanFreq()"
[76] "fBodyBodyGyroMag-mean()"              "fBodyBodyGyroMag-std()"               "fBodyBodyGyroMag-meanFreq()"
[79] "fBodyBodyGyroJerkMag-mean()"          "fBodyBodyGyroJerkMag-std()"           "fBodyBodyGyroJerkMag-meanFreq()"
[82] "angle(tBodyAccMean,gravity)"          "angle(tBodyAccJerkMean),gravityMean)" "angle(tBodyGyroMean,gravityMean)"
[85] "angle(tBodyGyroJerkMean,gravityMean)" "angle(X,gravityMean)"                 "angle(Y,gravityMean)"
[88] "angle(Z,gravityMean)"



### 

### Raw Data Feature Selection

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

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

---

