==================================================================
Getting and Cleaning Data
Course Project
==================================================================
github user: cgberg128
using data from:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

```
In the "run_analysis.R" script, datasets are first read in from Samsung data.  I first combined all train and test data using rbind function.  I then assigned column names appropriately from the features dataset.  Next, I used regular expressions to select only those columns that corresponded to a mean or standard deviation measurement.  At this point, I have a tidy dataset which I call tidy_df_1.  Finally, I utilized dplyr to create a second tidy dataset (called tidy_df_2) in which I calculated the mean (by subject and activity combination) of all measurements I kept in the first tidy dataset.  tidy_df_2 is a tidy dataset, as each row contains averages of various measurements for each possibility of subj_act_comb variable (the first column in the dataset).
```

```
Codebook is given below. 180 rows (30 subjects x 6 activities) and 69 variables in "tidy_df_2" dataset created in run_analysis.R.  Please note that all measurements are unitless, as original measurements were normalized to be within [-1,1].

- subj_act_comb:  Concatenation of subject_label and activity_desc (with hyphen as separator)
- subject_label: Subject ID (1 through 30 are possible values)
- activity_desc:  Description of activity
- tBodyAcc-mean()-X: Average of mean of tBodyAcc measurement of subject while doing activity
- tBodyAcc-mean()-Y: Average of mean of tBodyAcc measurement of subject while doing activity
- tBodyAcc-mean()-Z: Average of mean of tBodyAcc measurement of subject while doing activity
- tBodyAcc-std()-X: Average of standard deviation of tBodyAcc measurement of subject while doing activity
- tBodyAcc-std()-Y: Average of standard deviation of tBodyAcc measurement of subject while doing activity
- tBodyAcc-std()-Z: Average of standard deviation of tBodyAcc measurement of subject while doing activity
- tGravityAcc-mean()-X: Average of mean of tGravityAcc measurement of subject while doing activity
- tGravityAcc-mean()-Y: Average of mean of tGravityAcc measurement of subject while doing activity
- tGravityAcc-mean()-Z: Average of mean of tGravityAcc measurement of subject while doing activity
- tGravityAcc-std()-X: Average of standard deviation of tGravityAcc measurement of subject while doing activity
- tGravityAcc-std()-Y: Average of standard deviation of tGravityAcc measurement of subject while doing activity
- tGravityAcc-std()-Z: Average of standard deviation of tGravityAcc measurement of subject while doing activity
- tBodyAccJerk-mean()-X: Average of mean of tBodyAccJerk measurement of subject while doing activity
- tBodyAccJerk-mean()-Y: Average of mean of tBodyAccJerk measurement of subject while doing activity
- tBodyAccJerk-mean()-Z: Average of mean of tBodyAccJerk measurement of subject while doing activity
- tBodyAccJerk-std()-X: Average of standard deviation of tBodyAccJerk measurement of subject while doing activity
- tBodyAccJerk-std()-Y: Average of standard deviation of tBodyAccJerk measurement of subject while doing activity
- tBodyAccJerk-std()-Z: Average of standard deviation of tBodyAccJerk measurement of subject while doing activity
- tBodyGyro-mean()-X: Average of mean of tBodyGyro measurement of subject while doing activity
- tBodyGyro-mean()-Y: Average of mean of tBodyGyro measurement of subject while doing activity
- tBodyGyro-mean()-Z: Average of mean of tBodyGyro measurement of subject while doing activity
- tBodyGyro-std()-X: Average of standard deviation of tBodyGyro measurement of subject while doing activity
- tBodyGyro-std()-Y: Average of standard deviation of tBodyGyro measurement of subject while doing activity
- tBodyGyro-std()-Z: Average of standard deviation of tBodyGyro measurement of subject while doing activity
- tBodyGyroJerk-mean()-X: Average of mean of tBodyGyroJerk measurement of subject while doing activity
- tBodyGyroJerk-mean()-Y: Average of mean of tBodyGyroJerk measurement of subject while doing activity
- tBodyGyroJerk-mean()-Z: Average of mean of tBodyGyroJerk measurement of subject while doing activity
- tBodyGyroJerk-std()-X: Average of standard deviation of tBodyGyroJerk measurement of subject while doing activity
- tBodyGyroJerk-std()-Y: Average of standard deviation of tBodyGyroJerk measurement of subject while doing activity
- tBodyGyroJerk-std()-Z: Average of standard deviation of tBodyGyroJerk measurement of subject while doing activity
- tBodyAccMag-mean(): Average of mean of tBodyAccMag measurement of subject while doing activity
- tBodyAccMag-std(): Average of standard deviation of tBodyAccMag measurement of subject while doing activity
- tGravityAccMag-mean(): Average of mean of tGravityAccMag measurement of subject while doing activity
- tGravityAccMag-std(): Average of standard deviation of tGravityAccMag measurement of subject while doing activity
- tBodyAccJerkMag-mean(): Average of mean of tBodyAccJerkMag measurement of subject while doing activity
- tBodyAccJerkMag-std(): Average of standard deviation of tBodyAccJerkMag measurement of subject while doing activity
- tBodyGyroMag-mean(): Average of mean of tBodyGyroMag measurement of subject while doing activity
- tBodyGyroMag-std(): Average of standard deviation of tBodyGyroMag measurement of subject while doing activity
- tBodyGyroJerkMag-mean(): Average of mean of tBodyGyroJerkMag measurement of subject while doing activity
- tBodyGyroJerkMag-std(): Average of standard deviation of tBodyGyroJerkMag measurement of subject while doing activity
- fBodyAcc-mean()-X: Average of mean of fBodyAcc measurement of subject while doing activity
- fBodyAcc-mean()-Y: Average of mean of fBodyAcc measurement of subject while doing activity
- fBodyAcc-mean()-Z: Average of mean of fBodyAcc measurement of subject while doing activity
- fBodyAcc-std()-X: Average of standard deviation of fBodyAcc measurement of subject while doing activity
- fBodyAcc-std()-Y: Average of standard deviation of fBodyAcc measurement of subject while doing activity
- fBodyAcc-std()-Z: Average of standard deviation of fBodyAcc measurement of subject while doing activity
- fBodyAccJerk-mean()-X: Average of mean of fBodyAccJerk measurement of subject while doing activity
- fBodyAccJerk-mean()-Y: Average of mean of fBodyAccJerk measurement of subject while doing activity
- fBodyAccJerk-mean()-Z: Average of mean of fBodyAccJerk measurement of subject while doing activity
- fBodyAccJerk-std()-X: Average of standard deviation of fBodyAccJerk measurement of subject while doing activity
- fBodyAccJerk-std()-Y: Average of standard deviation of fBodyAccJerk measurement of subject while doing activity
- fBodyAccJerk-std()-Z: Average of standard deviation of fBodyAccJerk measurement of subject while doing activity
- fBodyGyro-mean()-X: Average of mean of fBodyGyro measurement of subject while doing activity
- fBodyGyro-mean()-Y: Average of mean of fBodyGyro measurement of subject while doing activity
- fBodyGyro-mean()-Z: Average of mean of fBodyGyro measurement of subject while doing activity
- fBodyGyro-std()-X: Average of standard deviation of fBodyGyro measurement of subject while doing activity
- fBodyGyro-std()-Y: Average of standard deviation of fBodyGyro measurement of subject while doing activity
- fBodyGyro-std()-Z: Average of standard deviation of fBodyGyro measurement of subject while doing activity
- fBodyAccMag-mean(): Average of mean of fBodyAccMag measurement of subject while doing activity
- fBodyAccMag-std(): Average of standard deviation of fBodyAccMag measurement of subject while doing activity
- fBodyBodyAccJerkMag-mean(): Average of mean of fBodyBodyAccJerkMag measurement of subject while doing activity
- fBodyBodyAccJerkMag-std(): Average of standard deviation of fBodyBodyAccJerkMag measurement of subject while doing activity
- fBodyBodyGyroMag-mean(): Average of mean of fBodyBodyGyroMag measurement of subject while doing activity
- fBodyBodyGyroMag-std(): Average of standard deviation of fBodyBodyGyroMag measurement of subject while doing activity
- fBodyBodyGyroJerkMag-mean(): Average of mean of fBodyBodyGyroJerkMag measurement of subject while doing activity
- fBodyBodyGyroJerkMag-std(): Average of standard deviation of fBodyBodyGyroJerkMag measurement of subject while doing activity
```