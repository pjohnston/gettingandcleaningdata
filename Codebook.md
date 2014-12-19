# Getting and Cleaning Data - Coursera Course. Course Project
Paul Johnston
12/8/2014

## Codebook.md
This is the codebook for this project.
See the README.txt file for details on the process for performing the analysis.

Data for the project is located here.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

See the included README.txt file in that zip for details on the variables in the source data and a description of each.

## activityData
Here is a description of the set generated in a variablke called "activityData" in the environment as a result of executing the analytics using
the run_analysis.R script

```
> activityData
Source: local data frame [10,299 x 81]

   activity_name subject_id tbodyacc_mean_x tbodyacc_mean_y tbodyacc_mean_z tbodyacc_std_x tbodyacc_std_y tbodyacc_std_z tgravityacc_mean_x
1       STANDING          2       0.2571778     -0.02328523     -0.01465376     -0.9384040     -0.9200908     -0.6676833          0.9364893
2       STANDING          2       0.2860267     -0.01316336     -0.11908252     -0.9754147     -0.9674579     -0.9449582          0.9274036
3       STANDING          2       0.2754848     -0.02605042     -0.11815167     -0.9938190     -0.9699255     -0.9627480          0.9299150
4       STANDING          2       0.2702982     -0.03261387     -0.11752018     -0.9947428     -0.9732676     -0.9670907          0.9288814
5       STANDING          2       0.2748330     -0.02784779     -0.12952716     -0.9938525     -0.9674455     -0.9782950          0.9265997
6       STANDING          2       0.2792199     -0.01862040     -0.11390197     -0.9944552     -0.9704169     -0.9653163          0.9256632
7       STANDING          2       0.2797459     -0.01827103     -0.10399988     -0.9958192     -0.9763536     -0.9777247          0.9261366
8       STANDING          2       0.2746005     -0.02503513     -0.11683085     -0.9955944     -0.9820689     -0.9852624          0.9265862
9       STANDING          2       0.2725287     -0.02095401     -0.11447249     -0.9967841     -0.9759063     -0.9865970          0.9255553
10      STANDING          2       0.2757457     -0.01037199     -0.09977589     -0.9983731     -0.9869329     -0.9910219          0.9241734
..           ...        ...             ...             ...             ...            ...            ...            ...                ...
```

This contains merged training and test sets to create one data set, but only measurements for variables representing the standard deviation (acitivyt name contains _std_)
and mean (acitivty name contains _mean_) have been extracted from the source data set. There is one row per activity per subject for all variables measured each time they
were measure for each subject and acitivy.

* **activity_name**: values in this field are taken from the source "activity_labels.txt" file and represent the activity
* **subject_id**: this is a unique value representing the subject who carried out the experiment
* The other columns all represent a measure of variables on features in the source signal data set.

## tidyActivityData
This data is then further analyed to create a "tidy.txt" data set with exactly 4 columns:

* **activity_name**: values in this field are taken from the source "activity_labels.txt" file and represent the activity
* **subject_id**:  this is a unique value representing the subject who carried out the experiment
* **measure**: this contains the name of the measured variable
* **mean_value**: this contains the mean value of the mesaured variable across all measurements of that variable for a particular activity and subject.

This is exactly one row per activity per subject per measure in this tidy data set. Data is sorted by activity_name then subject_id then measure.
Post analysis, this tidy data has also been made available in an environment value called "tidyActivityData":

```
> tidyActivityData
Source: local data frame [14,220 x 4]
Groups: activity_name, subject_id

   activity_name subject_id            measure  mean_value
1         LAYING          1    tbodyacc_mean_x  0.22159824
2         LAYING          1    tbodyacc_mean_y -0.04051395
3         LAYING          1    tbodyacc_mean_z -0.11320355
4         LAYING          1     tbodyacc_std_x -0.92805647
5         LAYING          1     tbodyacc_std_y -0.83682741
6         LAYING          1     tbodyacc_std_z -0.82606140
7         LAYING          1 tgravityacc_mean_x -0.24888180
8         LAYING          1 tgravityacc_mean_y  0.70554977
9         LAYING          1 tgravityacc_mean_z  0.44581772
10        LAYING          1  tgravityacc_std_x -0.89683002
..           ...        ...                ...         ...

```