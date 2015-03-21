## Step 1
# Descriptions to each step are included in the README file. Please refer to it torun this script.
# Also please refer to the CodeBook included in the reporsitory to understand the variables and the 
# transformations made to obtain the final tidy subset. 

install.packages("bitops")
install.packages("RCurl")
install.packages("dplyr")
install.packages("car")

## Step 2

library("bitops")
library("RCurl")
library("car")
library("dplyr")

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

temp <- tempfile()
download.file(URL, method='curl', temp)

## Step 3

unzipped_data <- unzip(temp, files = NULL, list = FALSE, overwrite = TRUE,
                       junkpaths = FALSE, 
                       exdir = ".", 
                       unzip = "internal",
                       setTimes = FALSE)
unlink(temp)

unzipped_data


## Step 3

X_test.txt <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test.txt <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test.txt <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_train.txt <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train.txt <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train.txt <- read.table("./UCI HAR Dataset/train/subject_train.txt")


## Step 4

features_names <- read.table("./UCI HAR Dataset/features.txt")
test_column_labels <- as.vector(t(features_names[,2]))
train_column_labels <- as.vector(t(features_names[,2]))

colnames(X_test.txt) <- test_column_labels
colnames(X_train.txt) <- train_column_labels


## Step 5

colnames(y_test.txt) <- "Activity"
colnames(y_train.txt) <- "Activity"
colnames(subject_test.txt) <- "Subject"
colnames(subject_train.txt) <- "Subject"


## Step 6

activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt")

activity_names


## Step 7

test_activity_labels <- lapply(y_test.txt, FUN = function(foo) recode(foo, "1 = 'WALKING' ; 2 = 
                              'WALKING UPSTAIRS' ; 3 = 'WALKING DOWNSTAIRS' ; 4 = 'SITTING' ;
                               5 = 'STANDING' ; 6 = 'LAYING'"))

test_activity_labels <- data.frame(test_activity_labels)

train_activity_labels <- lapply(y_train.txt, FUN = function(foo) recode(foo, "1 = 'WALKING' ; 2 = 
                              'WALKING UPSTAIRS' ; 3 = 'WALKING DOWNSTAIRS' ; 4 = 'SITTING' ;
                               5 = 'STANDING' ; 6 = 'LAYING'"))

train_activity_labels <- data.frame(train_activity_labels)


## Step 8

test.txt <- cbind(X_test.txt, test_activity_labels)


## Step 9 

train.txt <- cbind(X_train.txt, train_activity_labels)


## Step 10

tidy_test <- cbind(test.txt, subject_test.txt)
tidy_train <- cbind(train.txt, subject_train.txt)


## Step 11

tidy_data <- rbind(tidy_test, tidy_train)


## Step 12

valid_column_names <- make.names(names=names(tidy_data), unique=TRUE, allow_ = TRUE)
names(tidy_data) <- valid_column_names

subset_mean <- select(tidy_data, contains("mean"))

subset_std <- select(tidy_data, contains("std"))

subset_id <- select(tidy_data, Subject, Activity)

subset_tidy <- cbind(subset_id, subset_mean, subset_std)


## Step 13

mydata_arranged <-arrange(subset_tidy, Subject, Activity)


## Step 14

by_subject_act <-  mydata_arranged %>% group_by(Subject,Activity)

project_tidy <- by_subject_act %>% summarise_each(funs(mean))

## Step 15
# you should use you our location path here to write the text file into your machine

my_tidy_data <- write.table(project_tidy, 
                            file = "set your own location path here/my_tidy_data.txt",
                            row.name=FALSE)







