library(dplyr)

# Read in the training and testing data sets, and clean up column names.
train_subject = read.table("train/subject_train.txt")
train_values = read.table("train/X_train.txt")
train_activities = read.table("train/y_train.txt")

test_subject = read.table("test/subject_test.txt")
test_values = read.table("test/X_test.txt")
test_activities = read.table("test/y_test.txt")

activity_labels = read.table("activity_labels.txt")
features = read.table("features.txt")
cleanfeatures <- gsub("\\.\\.", "", make.names(features[,"V2"]))
cleanfeatures <- gsub("BodyBody", "Body", cleanfeatures)

colnames(train_values) <- cleanfeatures
colnames(test_values) <- cleanfeatures
colnames(train_subject) <- c("subject")
colnames(test_subject) <- c("subject")
colnames(train_activities) <- c("activityid")
colnames(test_activities) <- c("activityid")
colnames(activity_labels) <- c("activityid", "activityname")


# Merges the training and the test sets to create one data set.

## Blend the columns within each of test and train
train_values$subject <- train_subject$subject
train_values$activityid <- train_activities$activityid
test_values$subject <- test_subject$subject
test_values$activityid <- test_activities$activityid

## Then union the two sets (same variables in each, just adds rows to the total)
alldata <- rbind(train_values, test_values)



# Extracts only the measurements on the mean and standard deviation for each measurement. 

## Look in column names for "mean" but then take away any "meanFreq" cols, don't need them.
meanscols <- grep("mean", names(alldata), value=TRUE)
meanfreqcols <- grep("meanFreq", names(alldata), value=TRUE)

## If we decide to keep meanFreq columns, comment out the following statement to change the behavior.
meanscols <- meanscols[!is.element(meanscols, meanfreqcols)]

## Keep all the standard deviation columns
stdcols <- grep("std", names(alldata), value=TRUE)
keepcols <- c("subject", "activityid", meanscols, stdcols)
importantdata <- alldata[,keepcols]


# Uses descriptive activity names to name the activities in the data set
namedactivities<- merge(importantdata, activity_labels, by.x="activityid", by.y="activityid", all.x=TRUE)


# Appropriately labels the data set with descriptive variable names.
## Mostly taken care of when joining in the features.txt earlier; these names are far 
## more descriptive than V1, V2, V3.  See code book file for further details.


# From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.
averages<-summarise_each(group_by(namedactivities, subject, activityname, activityid), funs(mean))
meannames<- c(names(averages)[1:3], paste("mean", names(averages)[4:69], sep="."))
colnames(averages)<-meannames

# Please upload your data set as a txt file created with write.table() using row.name=FALSE
write.table(averages, file="averages.txt", row.names=FALSE, append=FALSE)

# Modify and update the code book with your new data.
## This saves the names of the columns for the new file, but the code book 
## will be edited by hand afterwards in a separate file based on this one.
write.table(names(averages), file="fields.txt", row.names=FALSE, append=FALSE)
