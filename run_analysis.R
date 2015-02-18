library(sqldf)
library(plyr)
library(dplyr)
#3 libraries used for this assignment
#sqldf allows for use of SQL statements within R
#plyr and dplyr allow for brilliant manipulation of datasets within R

#Data was obtained from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
#Zip file for the data is here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

#User will need to change working directory to where the Samsung data is located
#Specifically, the following files are used in the code:
#1) "features.txt"
#2) "X_train.txt"
#3) "X_test.txt"
#4) "subject_train.txt"
#5) "subject_test.txt"
#6) "y_train.txt"
#7) "y_test.txt"
#8) "activity_labels.txt"

features <- read.table("features.txt",stringsAsFactors=FALSE)
main_train <- read.table("X_train.txt",stringsAsFactors=FALSE)
main_test <- read.table("X_test.txt",stringsAsFactors=FALSE)
#Reading in 3 of our datasets

main_combined <- rbind(main_train,main_test)
#Stacking train and test data using rbind function
#Before we add subject and activity columns
#or filter out any columns that are not means or standard deviation measurements

colnames(main_combined) <- features$V2
#Variable names come from the features dataset


mean_check <- regexpr("mean",features$V2)
meanfreq_check <- regexpr("meanFreq",features$V2)
std_check <- regexpr("std",features$V2)
#Using regexpr function to check whether column names contain the expressions:
#"mean" (for mean measurements)
#"meanFreq" (we will filter these out, but needed because "mean" is contained in "meanFreq")
#"std" (for standard deviation measurements)

features_with_checks <- cbind(features,mean_check,meanfreq_check,std_check)
#Regular expression checking


mean_or_sd_indices <- subset(features_with_checks,
                             (mean_check != -1 & meanfreq_check == -1) | 
                               std_check != -1)
#Filtering on those records that contain "mean" or "std" but do NOT contain "meanFreq"

mean_or_sd_indices <- mean_or_sd_indices$V1

main_filtered <- main_combined[,mean_or_sd_indices]
#Dataset that contains only observations corresponding to means or stds



#Now, we need to add on subject and activity information
subject_train <- read.table("subject_train.txt",stringsAsFactors=FALSE)
subject_test <- read.table("subject_test.txt",stringsAsFactors=FALSE)
subject_combined <- rbind(subject_train,subject_test)
colnames(subject_combined) <- c("subject_label")
#Stacking subject label data before attaching as a new column to main combined dataset


activity_train <- read.table("y_train.txt",stringsAsFactors=FALSE)
activity_test <- read.table("y_test.txt",stringsAsFactors=FALSE)
activity_combined <- rbind(activity_train,activity_test)
#Stacking activity label data before attaching as a new column to main combined dataset

activity_labels <- read.table("activity_labels.txt",stringsAsFactors=FALSE)



activity_label_and_desc <- sqldf("select a.V1 as activity_label,
                           b.V2 as activity_desc
                           from activity_combined a left join activity_labels b
                           on a.V1=b.V1")


activity_desc <- activity_label_and_desc$activity_desc

subj_act_comb <- paste(subject_combined$subject_label,activity_desc,sep="-")

tidy_df_1 <- cbind(subj_act_comb,subject_combined,activity_desc,main_filtered) %>%
  mutate(activity_desc = as.character(activity_desc),
         subj_act_comb = as.character(subj_act_comb))

dim(tidy_df_1)
glimpse(tidy_df_1)
#Checking the dimensions of our first tidy dataset
#Contains one variable per column and one observation of each variable in a different row
#Not yet summarized by subject and activity
#Each row contains various measurements for a given subject and activity (i.e. subj_act_comb, which is first column)

#Now we just need to create another tidy dataset with the average of each variable
#for each activity and each subject

tidy_df_2 <- tidy_df_1 %>%
  select(-subj_act_comb) %>% #Can't take the average of this variable (a character variable).  We will re-create after summarizing.
  group_by(subject_label,activity_desc) %>%
  summarise_each(funs(mean)) %>%
  arrange(subject_label)
#Summarise_each function in dplyr allows us to quickly calculate the means of every column
#for whatever we group by (in this case, subject and activity)

subj_act_comb <- paste(tidy_df_2$subject_label,tidy_df_2$activity_desc,sep="-")

tidy_df_2 <- cbind(subj_act_comb,tidy_df_2) %>% 
      mutate(subj_act_comb = as.character(subj_act_comb))

dim(tidy_df_2)
glimpse(tidy_df_2)
#Checking dimensins of our final tidy dataset
#And taking a look at the variables

write.table(tidy_df_2,"tidy_df_2.txt",row.names=FALSE)
#Finally, writing our second tidy dataset to a .txt file
#Contains average of all variables from our first dataset
#for each subject/activity combination



