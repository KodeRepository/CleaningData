# Introduction to  `run_analysis.R`

- Downloads the data from [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/index.html)
- merges the training and test sets to create one data set
- replaces the numeric activity values in the dataset with descriptive textual activity names
- extracts  the measurements the mean and standard deviation  for each measurement
- Labels the columns with descriptive names
- creates a new tidy dataset with an average of each variable for each each activity and subject. 
- The dataset of averages is exported to a text file (row.name=FALSE)



# Input data sets

- The input data set is split into training and test sets.
- Each partition is split into three files that contain measurements from the accelerometer and gyroscope,activity label and the subject identifier

# Data Processing - Retrieval of data and Cleaning

 - Dowload the data from UCI Repositoty
 - 
The first step of the preprocessing is to merge the training and test
sets. Two sets combined, there are 10,299 instances where each
instance contains 561 features (560 measurements and subject identifier). After
the merge operation the resulting data, the table contains 562 columns (560
measurements, subject identifier and activity label).

After the merge operation, mean and standard deviation features are extracted
for further processing. Out of 560 measurement features, 33 mean and 33 standard
deviations features are extracted, yielding a data frame with 68 features
(additional two features are subject identifier and activity label).

Next, the activity labels are replaced with descriptive activity names, defined
in `activity_labels.txt` in the original data folder.

The final step creates a tidy data set with the average of each variable for
each activity and each subject. 10299 instances are split into 180 groups (30
subjects and 6 activities) and 66 mean and standard deviation features are
averaged for each group. The resulting data table has 180 rows and 66 columns.
The tidy data set is exported to `UCI_Averages_After_CleanUp.txt` where the first row is the
header containing the names for each column.
