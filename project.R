filename <- "project.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, filename, method="curl")
unzip(filename) 

features <- read.table("/Users/yinjiaxi/Desktop/UCI HAR Dataset/features.txt", colnames = c("n","functions"))
activities <- read.table("/Users/yinjiaxi/Desktop/UCI HAR Dataset/activity_labels.txt", colnames = c("code", "activity"))
subject_test <- read.table("/Users/yinjiaxi/Desktop/UCI HAR Dataset/test/subject_test.txt", colnames = "subject")
x_test <- read.table("/Users/yinjiaxi/Desktop/UCI HAR Dataset/test/X_test.txt", colnames = features$functions)
y_test <- read.table("/Users/yinjiaxi/Desktop/UCI HAR Dataset/test/y_test.txt", colnames = "code")
subject_train <- read.table("/Users/yinjiaxi/Desktop/UCI HAR Dataset/train/subject_train.txt", colnames = "subject")
x_train <- read.table("/Users/yinjiaxi/Desktop/UCI HAR Dataset/train/X_train.txt", colnames = features$functions)
y_train <- read.table("/Users/yinjiaxi/Desktop/UCI HAR Dataset/train/y_train.txt", colnames = "code")

## Merges the training and the test sets to create one data set.
data_train<-data.frame(subject_train,y_train,x_train)
data_test<-data.frame(subject_test,y_test,x_test)
merged_data<-rbind(data_train,data_test)

## Extracts only the measurements on the mean and standard deviation for each measurement.
index_select<-grep("mean|std",features$functions)
sub_data<-merged_data[,c(1,2,index_select+2)]

## Uses descriptive activity names to name the activities in the data set
merged_data$code<-activities[merged_data$code,2]

## Appropriately labels the data set with descriptive variable names.
colnames(merged_data)[2]<-"activity"
colnames(merged_data)<-gsub("Acc", "Accelerometer", colnames(merged_data))
colnames(merged_data)<-gsub("Gyro", "Gyroscope", colnames(merged_data))
colnames(merged_data)<-gsub("Mag", "Magnitude", colnames(merged_data))
colnames(merged_data)<-gsub("^t", "Time", colnames(merged_data))
colnames(merged_data)<-gsub("^f", "Frequency", colnames(merged_data))
colnames(merged_data)<-gsub("tBody", "TimeBody", colnames(merged_data))


## From the data set in step 4, creates a second, independent tidy data set with the average 
## of each variable for each activity and each subject.
tidy_data<-aggregate(sub_data,by=list(sub_data$activity,sub_data$subject),FUN=mean)
write.table(tidy_data, "TidyData.txt", row.names=FALSE)