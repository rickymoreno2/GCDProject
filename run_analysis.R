## Step 1
# This step installs the necessary packages to download from an HTTPS URL, 
# It also installs the package used mamipulate and merge the data later

install.packages("bitops")
install.packages("RCurl")
install.packages("dplyr")
install.packages("car")

## Step 2
# This step is used to download and unzip the zip files and create a temporary file

library("bitops")
library("RCurl")
library("car")
library("dplyr")

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

temp <- tempfile()
download.file(URL, method='curl', temp)

## Step 3
# This step is used to unzip folder into the working directory and to create 
# a R object to easy access the file names (printed at the end). 
# The step also unlinks the temporary file


unzipped_data <- unzip(temp, files = NULL, list = FALSE, overwrite = TRUE,
                       junkpaths = FALSE, 
                       exdir = ".", 
                       unzip = "internal",
                       setTimes = FALSE)
unlink(temp)

unzipped_data

## Step 3
# This step is used to read the test and train files and create the R objects 
# that will be used to merge the data

X_test.txt <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test.txt <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test.txt <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_train.txt <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train.txt <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train.txt <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## Step 4
# This steps reads the features.txt file and into R as features_names, and then turns into a
# character vector that will be used as a header for X_test.txt (and later X_train.txt data)

features_names <- read.table("./UCI HAR Dataset/features.txt")
test_column_labels <- as.vector(t(features_names[,2]))
train_column_labels <- as.vector(t(features_names[,2]))

colnames(X_test.txt) <- test_column_labels
colnames(X_train.txt) <- train_column_labels

## Step 5
# This step will create a header called "Activity" for the y_test.txt and x_train.txt objects and
# it will create a header colled "Subject" to the subject_test.txt and subject_train.txt objects

colnames(y_test.txt) <- "Activity"
colnames(y_train.txt) <- "Activity"
colnames(subject_test.txt) <- "Subject"
colnames(subject_train.txt) <- "Subject"

## Step 6
# This step reads the activity_labels.txt file and create a R object called activity_names
# The step also prints activity_names out to be used as a reference in the next step 

activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt")

activity_names

## Step 7
# This step converts the y_test.txt and y_train.txt files into actual labels or activity names 
# that will later be used as the "activity" row for the tidy data set

test_activity_labels <- lapply(y_test.txt, FUN = function(foo) recode(foo, "1 = 'WALKING' ; 2 = 
                              'WALKING UPSTAIRS' ; 3 = 'WALKING DOWNSTAIRS' ; 4 = 'SITTING' ;
                               5 = 'STANDING' ; 6 = 'LAYING'"))

test_activity_labels <- data.frame(test_activity_labels)

train_activity_labels <- lapply(y_train.txt, FUN = function(foo) recode(foo, "1 = 'WALKING' ; 2 = 
                              'WALKING UPSTAIRS' ; 3 = 'WALKING DOWNSTAIRS' ; 4 = 'SITTING' ;
                               5 = 'STANDING' ; 6 = 'LAYING'"))

train_activity_labels <- data.frame(train_activity_labels)

## Step 8
# This step will merge the X_test.txt R and test_activity_labels R objects by 
# adding test_activity_labels as a column and creating a new R object called test.txt

test.txt <- cbind(X_test.txt, test_activity_labels)


## Step 9 
# This step is the same as step 7 but it will merge the X_train.txt R and train_activity_labels 
# R objects by adding test_activity_labels as a column and creating a new R object 
# called train.txt

train.txt <- cbind(X_train.txt, train_activity_labels)


## Step 10
# In this step a new column with be added to test.txt using the data from subject_test.txt and
# the result will be made into an R object called tidy_test
# In similar fashion, a new column will be added to train.txt using the data from subject_train.txt
# and the result will be made into an R object called tidy_train

tidy_test <- cbind(test.txt, subject_test.txt)
tidy_train <- cbind(train.txt, subject_train.txt)

## Step 11
#In this step tidy_est and tidy train will be merge into one set called tidy_data
# this step will merged the training and test sets into one, already with descriptive activity names
# and appropiate measurement labels

tidy_data <- rbind(tidy_test, tidy_train)

## Step 12
# In this step we will use dplyr functions to subset the data by means and standard deviation,
# as requested in item 2 of the instructions. It will keep the Activity and Subject columns to 
# be able to identify and group observations. The subsetted data will be called subset_tidy

valid_column_names <- make.names(names=names(tidy_data), unique=TRUE, allow_ = TRUE)
names(tidy_data) <- valid_column_names

subset_mean <- select(tidy_data, contains("mean"))

subset_std <- select(tidy_data, contains("std"))

subset_id <- select(tidy_data, Subject, Activity)

subset_tidy <- cbind(subset_id, subset_mean, subset_std)

tail(subset_tidy)

## Step 13

mydata_arranged <-arrange(subset_tidy, Subject, Activity)

head(mydata_arranged)

## Step 14
# this is the fucking answer!!!


by_subject_act <-  mydata_arranged %>% group_by(Subject,Activity)

head(by_subject_act)

project_tidy <- by_subject_act %>% summarise_each(funs(mean))

# Step 15

my_tidy_data <- write.table(project_tidy, 
                            file = "/Users/Ricky/datasciencecoursera/Getting and cleaning data/GCDProject/Project table/my_tidy_data.txt",
                            row.name=FALSE)


dim(project_tidy)






