print("Reading measurements, activities and subjects from Test Data ...")

features <- read.table("./UCI HAR Dataset/features.txt",
                       header=F,colClasses="character")
testMeasurements <- read.table("./UCI HAR Dataset/test/X_test.txt",header=F)
colnames(testMeasurements) <- features$V2
testActivities <- read.table("./UCI HAR Dataset/test/y_test.txt",header=F)
colnames(testActivities) <- c("Activity")
testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=F)
colnames(testSubjects) <- c("Subject")


print("Reading measurements, activities and subjects from Training Data ...")

trainMeasurements <- read.table("./UCI HAR Dataset/train/X_train.txt",header=F)
colnames(trainMeasurements) <- features$V2
trainActivities <- read.table("./UCI HAR Dataset/train/y_train.txt",header=F)
colnames(trainActivities) <- c("Activity")
trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=F)
colnames(trainSubjects) <- c("Subject")


print("1.-Merges the training and the test sets to create one data set...")

testMeasurements <- cbind(testMeasurements, testActivities)
testMeasurements <- cbind(testMeasurements, testSubjects)
trainMeasurements <- cbind(trainMeasurements, trainActivities)
trainMeasurements <- cbind(trainMeasurements, trainSubjects)

dataSet <- rbind(testMeasurements, trainMeasurements)

print("2.-Extracts only the measurements on the mean and standard deviation for each measurement...")

subsetCols <- grep("[Mm]ean|[Ss]td|Activity|Subject", colnames(dataSet))
dataSet <- dataSet[, subsetCols]


print("3.-Uses descriptive activity names to name the activities in the data set...")
print("4.-Appropriately labels the data set with descriptive activity names...")

levels_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",
                         header=F,colClasses="character")
dataSet$Activity <- factor(dataSet$Activity,levels=levels_labels$V1,
                           labels=levels_labels$V2)


print("5.-Creates a second, independent tidy data set with the average of each variable for each activity and each subject...")

library(reshape2)
idVars <- c("Activity", "Subject")
measureVars <- setdiff(colnames(dataSet), idVars)
meltedData <- melt(dataSet, id=idVars, measure.vars=measureVars)
tidyData <- dcast(meltedData, Activity + Subject ~ variable, mean)
write.table(tidyData, "tidyData.txt")