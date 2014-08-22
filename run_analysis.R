## Coursera : Getting and Clearning data: peer assessment
## Created by Olivia @ 8/21/2014

## Data source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## 1. Merges the training and the test sets to create one data set
rm(list=ls())
setwd("/Users/olivia/Documents/Course/GettingCleaningData/Project/UCI HAR Dataset")

## Read in raw data
feature_names <- read.table('features.txt')
train_x <- read.table('train/X_train.txt')
train_y <- scan('train/Y_train.txt')
train_subjects <- scan('train/subject_train.txt')
test_x <- read.table('test/X_test.txt')
test_y <- scan('test/Y_test.txt')
test_subjects <- scan('test/subject_test.txt')

# Set headers for training and test data
names(train_x) <- feature_names$V2
names(test_x) <- feature_names$V2

# Add column subject
train_x$subject <- train_subjects
test_x$subject <- test_subjects

# Add column activity
train_x$activity <- train_y
test_x$activity <- test_y

# Merge training and test data
data_all <- rbind(train_x, test_x)
dim(data_all)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## find the patterns "-mean()" and "-sd()" in the variable names
colsMeanSd_index <- grepl( '(-mean\\(\\)|-std\\(\\))', feature_names$V2 )
## extract the matched columns
colsMeanSd <- data_all[, c(which(colsMeanSd_index==TRUE),562,563)] # add subject and activity


## 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table('activity_labels.txt')
colsMeanSd$activity_label <- factor(colsMeanSd$activity, 
                                    levels=1:6, labels=activity_labels$V2)


## 4. Appropriately labels the data set with descriptive variable names
## check if naming are appropriate
names(colsMeanSd)
## variable names are already assigned by feature names

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
colsMeanSd$activity <- as.factor(colsMeanSd$activity)
colsMeanSd$subject <- as.factor(colsMeanSd$subject)
tidy <- aggregate(colsMeanSd[,-c(67:69)], by=list(activity = colsMeanSd$activity, activity_label = colsMeanSd$activity_label,subject=colsMeanSd$subject), mean)
write.table(tidy, "tidy.txt", sep="\t",row.names=FALSE)

