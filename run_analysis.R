# Getting and Cleaning Data - Coursera Course. Course Project
#
# Paul Johnston
# 12/8/2014

# One of the most exciting areas in all of data science right now is wearable computing 
# Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract 
# new users. The data linked to from the course website represent data collected from the accelerometers 
# from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Here are the data for the project:

# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# This script assumes the above data has been downloaded and 
# unzipped into the current working directory and then does the following:

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. Data is stored in the "activityData" variable.
# 5, Writes a tidy data set with the average of each variable for each activity and each subject to "tidy.txt" 
#    file in current working directory

# Merges the training and the test sets to create one data set.
# Note this script makes extensive use of the "dplyr" and "tidyr" R packages. Make sure those are loaded
library(dplyr)
library(tidyr)

# Load the "activities_labels.txt" file
# Label the column actiivyt_id and activity_name
activities <- read.table("activity_labels.txt", col.names=c("activity_id","activity_name"))

# Load the "features.txt" file
# Label the column actiivity_id and activity_name
features <- read.table("features.txt", col.names=c("feature_id","feature_name"))

#
# Load the test data - subject_test.txt, X_test.txt, y_test.txt
#

# - Subject file 1 column
testSubject <- read.table("test/subject_test.txt", col.names=c("subject_id"))
# Activities file - 1 column
testActivities <- read.table("test/y_test.txt", col.names=c("activity_id"))
# Features file - 561 columns, one per feature
testFeatures <- read.table("test/X_test.txt")

# Create a combined data.frame from the 3 test tables. 
testData <- data.frame(testSubject,testActivities,testFeatures)

#
# Load the training data - subject_train.txt, X_train.txt, y_train.txt
#

# - Subject file 1 column
trainSubject <- read.table("train/subject_train.txt", col.names=c("subject_id"))
# Activities file - 1 column
trainActivities <- read.table("train/y_train.txt", col.names=c("activity_id"))
# Features file - 561 columns, one per feature
trainFeatures <- read.table("train/X_train.txt")

# Create a combined data.frame from the 3 test tables. 
trainData <- data.frame(trainSubject,trainActivities,trainFeatures)

# Now combine the test and training data into a single data frame
mergedData <- rbind(testData,trainData)
# Set the column headers to the names of id plus "-" plus name of the measure (measure names are not unique and
# the dplyr "select" function requires them to be unique)
colnames(mergedData) <- c("subject_id","activity_id", as.character(paste(features$feature_id,"-",features$feature_name)))

meansAndStds <- mergedData %>%
  # Select columns using select that end in _id, or contain -std() or -mean()
  select(matches("_id$|-mean()|-std()"))

# We have unique column names now (guaranteed by select) so get rid of the "id - " from the front of them
colnames(meansAndStds) <- gsub("^(.* - )(.*$)","\\2",colnames(meansAndStds))
# and replace () and - with underscores and lowercase the column names
colnames(meansAndStds) <- tolower(gsub("\\(\\)$","",gsub("-","_",gsub("\\(\\)-+","_",colnames(meansAndStds)))))

# join in the names of the activities from the activity table using dplyr inner_join function
activityTmp <- tbl_df(inner_join(activities,meansAndStds,by="activity_id"))

# and get rid of the activity_id column.
activityData <-
  activityTmp %>%
  select(-contains("activity_id")
)

# So "activityData" variable now contains the (untidy) data we want.
# Now tidy it using tidyr into a variable called "tidyActivityData"

tidyActivityData <-
  activityData %>%
  # 1. Gather all the measures, to convert to a 4 column layout with activty_name, subject_id, measure and value
  gather(measure, value, tbodyacc_mean_x:fbodybodygyrojerkmag_meanfreq) %>%
  # 2. Group the data by activity and subject and measure
  group_by(activity_name,subject_id,measure) %>%
  # 3. Calculate the average measure by activity and subject
  summarize(mean_value = mean(value)) %>%
  # 4. Sort output data by activity, subject and measure
  arrange(activity_name, subject_id, measure)

# write it out to a txt file in the current working directory named "tidy.txt" without rownames
write.table(tidyActivityData,file="tidy.txt",row.names=FALSE)
