# my_tidy_data.txt Codebook

## This code book describes the modifications done to the original data files to produce the text file uploaded to coursera

1. The original dataset was downloaded and unzipped. The files used were the following:

* "./UCI HAR Dataset/test/X_test.txt"
* "./UCI HAR Dataset/test/y_test.txt"
* "./UCI HAR Dataset/test/subject_test.txt"
* "./UCI HAR Dataset/train/X_train.txt"
* "./UCI HAR Dataset/train/y_train.txt"
* "./UCI HAR Dataset/train/subject_train.txt"
* "./UCI HAR Dataset/features.txt"

### Files not used for this tidy data

2. The files in the "Inertial signal" folder for both test and train data were not used
for the created data set, because they were not mentioned in the instructions.

### Two columns (Activity and Subject) were added to original 561 columns:

3. "X_" and "y_" files were merged for both test and train data. y_ files were added to 
their respective X_ files as a new column to the right (first) and the new variable was 
labeled "Activity".

4. The Activity codes (1:6) in the activity column were transformed into the actual 
activity names, so that the date can be easily read, and user can create charts for each
activity name if they so wish. 

4. The subject files for both train and test were also merged to their respective X_ files 
as as the second column of the dataset. The column was labeled "Subject".

### Naming the original 561 columns:

5. The file "features.txt" was used to create a character vector that was applied to both 
the test and train data sets as the columns headers. For more information on these column 
names please refer to the original "./UCI HAR Dataset/features_info.txt" file for more 
information on these variable names (this file will be dowloaded and unzipped if you run 
the script)

### Final subsetting of the data

6. As requested in the instructions, the tidy data set produced by the script only 
includes the mean and standard deviation variables. All other variables (Except Activity 
and Subject) were removed from the dataset. 

7. Finally, as per the assignment instructions, the individual observations were transformed
to calculate the average of each variable for each subject for each activity. 

8. The final result is a table with 88 variables and 180 rows (if we don't count the 
header - 30 subjects x 6 Activities). 