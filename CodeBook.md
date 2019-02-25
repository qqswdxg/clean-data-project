The run_analysis.R script performs the data preparation and then followed by the 5 steps.
Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset

Assign each data to variables

subject_test contains test data of 9/30 volunteer test subjects being observed
x_test contains recorded features test data
y_test contains test data of activities’code labels
subject_train contains train data of 21/30 volunteer subjects being observed
x_train contains recorded features train data
y_train contains train data of activities’code labels

Merges the training and the test sets to create one data set
data_train is created by merging subject_train, y_train and x_train using data.frame() function
data_test is created by merging subject_test, y_test and x_test using data.frame() function
merged_Data is created by merging Subject, data_train and data_test using cbind() function

Extracts only the measurements on the mean and standard deviation for each measurement
sub_data is created by subsetting merged_data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the sub_data replaced with corresponding activity taken from second column of the  activities variable

Appropriately labels the data set with descriptive variable names
code column in sub_data renamed into activities
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All Mag in column’s name replaced by Magnitude


From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data is created by sumarizing sub_data taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export  tidy_data into TidyData.txt file.
