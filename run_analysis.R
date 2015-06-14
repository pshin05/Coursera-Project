library(plyr)
library(reshape2)
library(foreign)

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
Features <- read.csv(proj.features, header=F, sep="", col.names=c("ID", "Desc"))  

# Read Subject Files
proj.subj.test <- paste(proj.dataDir, "test", "subject_test.txt", sep="/")
proj.subj.train <- paste(proj.dataDir, "train", "subject_train.txt", sep="/")
Subj.test <- read.csv(proj.subj.test, header=F, sep="")
Subj.train <- read.csv(proj.subj.train, header=F, sep="")

# Sanity Checks
stopifnot(ncol(X.test) == nrow(Features))
stopifnot(ncol(X.test) == ncol(X.train))
stopifnot(nrow(X.test) == nrow(y.test))
stopifnot(nrow(X.test) == nrow(Subj.test))
stopifnot(nrow(X.train) == nrow(y.train))
stopifnot(nrow(X.train) == nrow(Subj.train))

# Merge the training and the test sets to create one data set.
X <- rbind(X.test, X.train)
y <- rbind(y.test, y.train)
Subj <- rbind(Subj.test, Subj.train)
stopifnot(nrow(X) == nrow(y))
stopifnot(nrow(X) == nrow(Subj))

# Appropriately labels the data set with descriptive variable names. 
colnames(X) <- Features$Desc
colnames(y) <- c("ActivityCode")

# Find All Features with "mean" or "std" in its description
Features <- transform(Features, MeanOrStd=regexpr('mean|std', Desc, ignore.case=T) > 0)
table(Features$MeanOrStd)

# Extract only the measurements on the mean and standard deviation for each measurement. 
X.MeanOrStd <- X[, Features$MeanOrStd]
dim(X.MeanOrStd)

# Add Subject Variable to X
X.MeanOrStd$Subject <- Subj[, 1]

# Read Activity Labels File
proj.activity <- paste(proj.dataDir, "activity_labels.txt", sep="/")
Activity <- read.csv(proj.activity, header=F, sep="", col.names=c("Code", "Label"))
dim(Activity)

# To reduce future confusion, relevel factors to match the code
unclass(Activity$Label)
Activity$Label <- factor(Activity$Label, levels=Activity$Label)
unclass(Activity$Label)

# Uses descriptive activity names to name the activities in the data set
head(y)
X.MeanOrStd$Activity <- Activity$Label[y$ActivityCode]
table(X.MeanOrStd$Activity, y$ActivityCode)

# Creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
X.Melted <- melt(X.MeanOrStd, id.vars = c("Subject", "Activity"))
head(X.Melted, n=4)
X2 <- tapply(X.Melted$value, 
             X.Melted[, c("Subject", "Activity", "variable")], mean)
X2 <- melt(X2, id.vars = c("Subject", "Activity"))
colnames(X2)[3:4] <- c("Variable", "Average")
head(X2)

# Final Tity Data
?write.table
write.table(X2, "averages.txt", row.names=F)
