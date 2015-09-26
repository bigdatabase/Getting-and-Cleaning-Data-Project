

################################################################################

# Getting and Cleaning Data : Project, 2015 Sep: run_analysis.R


################################################################################

#Getting data:

## download files:

  setwd("mypath")
  if (!file.exists("./data")) {dir.create("./data") }
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile = "./data/phone_rec_act.zip", method = "curl")

## unzip file:
  unzip ("./data/phone_rec_act.zip", exdir = "./data")


################################################################################

# 1) Merges the training and the test sets to create one data set.  
  
## reading csv file

  setwd("mypath/UCI HAR Dataset")

### read train: 
  Xtrain        <- read.table("./train/X_train.txt")
  SubjectTrain  <- read.table("./train/subject_train.txt")
  Ytrain        <- read.table("./train/y_train.txt")

  colnames(Ytrain)[1]           <- "activity"   # rename activity column           
  colnames(SubjectTrain)[1]     <- "subject"    # rename subject column 
                
  Train         <- cbind (SubjectTrain, Ytrain, Xtrain) 


### read test: 
  Xtest         <- read.table("./test/X_test.txt")
  SubjectTest   <- read.table("./test/subject_test.txt")
  Ytest         <- read.table("./test/y_test.txt")

  colnames(Ytest)[1]            <- "activity" 
  colnames(SubjectTest)[1]      <- "subject" 

  Test <- cbind (SubjectTest, Ytest, Xtest)


### Merge Train and Test 
  Merge <- rbind(Train, Test)


################################################################################

# 2) Extracts only the measurements on the mean and standard deviation 
     # for each measurement. 

  Features           <- read.table("features.txt" )          # get all var names

  library(dplyr)
  Mean_Std_features  <- filter(Features, grepl('mean|std', Features[,2]))
                                                      # get var with mean or std

  Mean_Std_N         <- 2+ Mean_Std_features[,1]  
                                      # get the col-number for corresponding Var

  Extract            <- Merge[, c(1,2,Mean_Std_N)]            # extract the vars


################################################################################

# 3) Uses descriptive activity names to name the activities in the data set

  library(car)
  Extract_descri        <- recode(Extract[,2],"1='WALKING'; 2='WALKING_UPSTAIRS'; 
                           3='WALKING_DOWNSTAIRS'; 4='SITTING'; 5='STANDING'; 
                           6='LAYING'")   

  Extract_descri_df     <- cbind(Extract[,1], Extract_descri, 
                                 Extract[, 3:ncol(Extract)])

  #correct names
  colnames(Extract_descri_df)    <- c("subject", "activity", 
                                  as.character( Mean_Std_features[,2] ))

 
 ###############################################################################
  
 # 4) Appropriately labels the data set with descriptive variable names. 
        ## check: names(Extract_descri_df), change according to readme.txt
 
 names(Extract_descri_df)<-gsub("^t", "time", names(Extract_descri_df))           
 names(Extract_descri_df)<-gsub("^f", "frequency", names(Extract_descri_df))
 names(Extract_descri_df)<-gsub("Acc", "Accelerometer", names(Extract_descri_df))
 names(Extract_descri_df)<-gsub("Gyro", "Gyroscope", names(Extract_descri_df))
 names(Extract_descri_df)<-gsub("Mag", "Magnitude", names(Extract_descri_df))
 names(Extract_descri_df)<-gsub("BodyBody", "Body", names(Extract_descri_df))
 
 
 ###############################################################################
 
 # 5) From the data set in step 4, creates a second, independent tidy data set 
        # with the average of each variable for each activity and each subject.
 
  # use library(plyr)
  Averages <- ddply(Extract_descri_df, .(subject, activity), 
                    function(x) colMeans(x[, 3:81]))

  write.table(Averages, file = "average.txt" , row.name = FALSE)
  
################################################################################

  # THE END.

  
