Getting and Cleaning Data - Coursera Course. Course Project
#
Paul Johnston
12/8/2014

One of the most exciting areas in all of data science right now is wearable computing 
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract 
new users. The data linked to from the course website represent data collected from the accelerometers 
from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

This run_analysis.R script assumes the above data has been downloaded and 
unzipped into the current working directory, the working directory is then set to the "UCI HAR Dataset" directory 
and then does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. Data is stored in the "activityData" variable in the environment.
5, Writes a tidy data set with the average of each variable for each activity and each subject to "tidy.txt" 
   file in current working directory

See detailed comments within the run_analytics.R script to see exactly how this is achieved.
Note this script makes extensive use of the "dplyr" and "tidyr" R packages by Hadley Wickham. 
result of source("run_analysis.R") will be a generated file in the current working directory named "tidy.txt" as noted in setp 5.
