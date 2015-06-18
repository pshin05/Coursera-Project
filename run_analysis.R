library(dplyr)
library(lubridate)
library(tidyr)

setwd('~/WORK/Coursera/Coursera_Getting and Cleaning Data/Codes')

# Download Data
proj.dataDir <- "UCI HAR Dataset"
proj.zip <- "Dataset.zip"
proj.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!dir.exists(proj.dataDir)) {
  if (!file.exists(proj.zip)) {
    download.file(proj.url, proj.zip, method="curl")
  }
  unzip(proj.zip)
}

# Data Paths
proj.test.X <- paste(proj.dataDir, "test", "X_test.txt", sep="/")
proj.test.y <- paste(proj.dataDir, "test", "y_test.txt", sep="/")
proj.train.X <- paste(proj.dataDir, "train", "X_train.txt", sep="/")
proj.train.y <- paste(proj.dataDir, "train", "y_train.txt", sep="/")

# Read Test Data
X.test <- read.csv(proj.test.X, header=F, sep="")
y.test <- read.csv(proj.test.y, header=F, sep="")
dim(X.test); dim(y.test)

# Read Train Data
X.train <- read.csv(proj.train.X, header=F, sep="")
y.train <- read.csv(proj.train.y, header=F, sep="")
dim(X.train); dim(y.train)

# Read Features File
proj.features <- paste(proj.dataDir, "features.txt", sep="/")
Features <- read.csv(proj.features, header=F, sep="", col.names=c("id", "desc"))  
?read.csv
# Read Subject Files
proj.subj.test <- paste(proj.dataDir, "test", "subject_test.txt", sep="/")
proj.subj.train <- paste(proj.dataDir, "train", "subject_train.txt", sep="/")
Subj.test <- read.csv(proj.subj.test, header=F, sep="", colClasses=c("integer"))
Subj.train <- read.csv(proj.subj.train, header=F, sep="", colClasses=c("integer"))

# Sanity Checks
stopifnot(ncol(X.test) == nrow(Features))
stopifnot(ncol(X.test) == ncol(X.train))
stopifnot(nrow(X.test) == nrow(y.test))
stopifnot(nrow(X.test) == nrow(Subj.test))
stopifnot(nrow(X.train) == nrow(y.train))
stopifnot(nrow(X.train) == nrow(Subj.train))

# Convert all data to dplyr format
X.test <- dplyr::tbl_df(X.test)
X.train <- dplyr::tbl_df(X.train)
y.test <- dplyr::tbl_df(y.test)
y.train <- dplyr::tbl_df(y.train)
Features <- dplyr::tbl_df(Features)
Subj.test <- dplyr::tbl_df(Subj.test)
Subj.train <- dplyr::tbl_df(Subj.train)

# Merge the training and the test sets to create one data set.
X <- dplyr::bind_rows(X.test, X.train)
y <- dplyr::bind_rows(y.test, y.train)
Subj <- dplyr::bind_rows(Subj.test, Subj.train)
stopifnot(nrow(X) == nrow(y))
stopifnot(nrow(X) == nrow(Subj))

# Appropriately labels the data set with descriptive variable names. 
colnames(X) <- Features$desc
colnames(y) <- c("activityCode")
colnames(Subj) <- "subject"

# Find All Features with "mean" or "std" in its description
Features <- Features %>% 
  mutate(meanOrStd=grepl('mean|std', Features$desc, ignore.case=T))

# Make a quick visual check
table(Features$meanOrStd)
head(Features, n=10)

# Extract only the measurements on the mean and standard deviation for each measurement. 
X.select <- X[, Features$meanOrStd]
dim(X.select)

# Add Subject Variable to X
X.select <- bind_cols(X.select, Subj)

# Read Activity Labels File
proj.activity <- paste(proj.dataDir, "activity_labels.txt", sep="/")
Activity <- read.csv(proj.activity, header=F, sep="", col.names=c("code", "label"))
dim(Activity)

# To reduce future confusion, relevel factors to match the code
unclass(Activity$label)
Activity$label <- factor(Activity$label, levels=Activity$label)
unclass(Activity$label)

# Use descriptive activity names to name the activities in the data set
head(y)
X.select$activity <- Activity$label[y$activityCode]

# Make a quick visual check (Result should be diagonal)
table(X.select$activity, y$activityCode)

# Creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
X.tidy <- X.select %>% 
  tidyr::gather(feature, value, -c(subject, activity)) %>%
  dplyr::group_by(subject, activity, feature) %>%
  dplyr::summarize(mean(value)) %>%
  dplyr::arrange(activity, subject)

# Quick Visual Check
X.tidy

# Write Tidy Data
write.table(X.tidy, "averages.txt", row.names=F)
