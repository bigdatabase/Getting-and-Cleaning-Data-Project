
codebook.md


data:
The dataset being used is collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 



variables:

files x_train, y_train, x_test, y_test, subject_train, subject_test and features contain the data, and file features has all the variable's name except 'subject' and 'activity'. The variables' name were further modified as described below. 


x_data, y_data and subject_data merge the previous datasets to further analysis.
features contains the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std_features, a numeric vector used to extract the desired data.
A similar approach is taken with activity names through the activities variable.
all_data merges x_data, y_data and subject_data in a big dataset.
Finally, averages_data contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans() and ease the development.



transformations or work:

The script "run_analysis.R" does the following:

1) download the files and unzip them
2) read files by read.table command, merge data of 'train' and 'test' using cbind and merge into one dataframe by rbind
3) use filter command (dplyr) to extract only the measurements on the mean and standard deviation for each measurement
4) use recode command (car) to name the activities in the data set with dexriptive activity names
5) use gsub command to labels the data set with descriptive variable names
6) use ddply command (plyr) from last step, creates a second, independent tidy data set with the average of each variable for each activity and each subject
7) write a txt file named 'average.txt' with write.table() using row.name=FALSE
