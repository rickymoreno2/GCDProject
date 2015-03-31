# GCDProject
## This is a repository created for the "Getting and Cleaning Data" Coursera class project.
 
 
##Script Steps:

The following steps need to be followed to run the script included in this repository
that produces the tidy data set for the project. Each step is explained below. 


# Step 1

- This step installs the necessary packages to download from an HTTPS URL. It also 
installs the package used mamipulate and merge the data later.

# Step 2

- This step is used to download and unzip the zip files and create a temporary file.

# Step 3

- This step is used to unzip folder into the working directory and to create a R object 
to easy access the file names (printed at the end). 
- The step also unlinks the temporary file.

# Step 4

- This step is used to read the test and train files and create the R objects that will 
be used to merge the data.

# Step 5
-This steps reads the features.txt file and into R as features_names, and then turns 
into a character vector that will be used as a header for X_test.txt (and later 
X_train.txt data).

# Step 5
- This step will create a header called "Activity" for the y_test.txt and x_train.txt 
objects and it will create a header colled "Subject" to the subject_test.txt and 
subject_train.txt objects.

# Step 6

- This step reads the activity_labels.txt file and create a R object called activity_names.
- The step also prints activity_names out to be used as a reference in the next step. 

# Step 7

- This step converts the y_test.txt and y_train.txt files into actual labels or activity 
names that will later be used as the "activity" row for the tidy data set.

# Step 8

- This step will merge the X_test.txt R and test_activity_labels R objects by adding 
test_activity_labels as a column and creating a new R object called test.txt.

# Step 9 

- This step is the same as step 7 but it will merge the X_train.txt R and 
train_activity_labels R objects by adding test_activity_labels as a column and creating a 
new R object called train.txt.

# Step 10

- In this step a new column with be added to test.txt using the data from subject_test.txt 
and the result will be made into an R object called tidy_test
- In similar fashion, a new column will be added to train.txt using the data from 
subject_train.txt and the result will be made into an R object called tidy_train

# Step 11

- In this step tidy_est and tidy train will be merge into one set called tidy_data this 
step will merged the training and test sets into one, already with descriptive activity 
names and appropiate measurement labels.

# Step 12

- In this step we will use dplyr a series of functions to subset the data by means and 
standard deviation, as requested in item 2 of the instructions. It will keep the Activity and 
Subject columns to be able to identify and group observations. The subsetted data will be 
called subset_tidy.
-This step will also make sure column names are unique using the make.names() function 
with unique parameter set to true.

# Step 13

-This step will use dplyr functions to arrange the data by subject first and then by 
activity 

# Step 14

- This step will group first the data by Subject and then by Activity. 

- Then it will create an object called by_subject_act and will use the summarize function
to calculate the mean for each activity for each subject. The R object created is called 
project_tidy

# Step 15 

- This the final step that will use the function write.table() with row.name=FALSE to 
create a text file called my_tidy_data.txt 
_ In this step is important that you set up your own path to a file in your computer 
where you want to write the tidy data set. 
