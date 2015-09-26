

This repository holds the documents and R code for coursera "Data Science" course "Getting and Cleaning data" project

The dataset being used is collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


The script "run_analysis.R" does the all steps described in the course project's definition. Details as follow:

1) download the files and unzip them
2) read files by read.table command, merge data of 'train' and 'test' using cbind and merge into one dataframe by rbind
3) use filter command (dplyr) to extract only the measurements on the mean and standard deviation for each measurement
4) use recode command (car) to name the activities in the data set with dexriptive activity names
5) use gsub command to labels the data set with descriptive variable names
6) use ddply command (plyr) from last step, creates a second, independent tidy data set with the average of each variable for each activity and each subject
7) write a txt file named 'average.txt' with write.table() using row.name=FALSE


Files:
1) README.md
2) codebook.md
3) run_analysis.R
4) average.txt
