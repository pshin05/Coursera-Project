## Coursera - Getting and Cleaning Data Project

### Introduction
The data set contained in "averages.txt" originates from the [recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The raw data from the experiment were collected and made available at [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The tidy data contained in "averages.txt" is a summary of the raw data downloaded from this UCI web site. In particular, it gives the calculated means for all features related to mean or std measurements in the raw data set (see below for detail) for each subject and activities.

### Data Set Information
The following is an excerpt from the description of the experiment on [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones):

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
> Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
> wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope,
> we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.
> The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly
> partitioned into two sets, where 70% of the volunteers was selected for generating the training data
> and 30% the test data. 

From this data set, only those features that are related to mean or std measurements were included. In addition, the test subject's identification and the particular activity he/she was performing at the time were read from separate data files and combined with the main data set to form a single data frame. Finally, the mean values for the selected features from the original dataset were calculated for each subject and activities.

The following are brief descriptions of all the features in the tidy dataset:

> 1 subject  : test subject id

> 2 activity : one of WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

> 3 - 88     : mean or std related features from original dataset (see 'features_info.txt' in the original dataset) 

### Processing Steps
The tidy data set in "averages.txt" were obtained from the [raw dataset](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names) in following steps:

1. Train and test data sets for `X`, `y` and `subject` were combined into single data sets, respectively.
2. Of all features in `X`, only those features containing "mean" or "std" in its name were selected.
3. Appended `subject` data to `X` as `subject` column.
4. Translated contents of `y` to corresponding activity labels (by matching them to contents of `activity_labels.txt`), then appended the result to `X` as `activity` column.
5. Converted `X` to long form to faciliate the summarizing process below.
6. Grouped and calculated mean of `X` by each subject and activity.
7. Coverted resulting summarized `X` back to wide form.
8. Wrote out the result to `averages.txt`.



