library(dplyr)

# --------------------------------------------------------------
# Prepare environment
setwd("c:/temp/R")


# --------------------------------------------------------------
# Load data into R from files
trainData <- read.table("./Dataset/train/X_train.txt")
trainDataActivity <- read.table("./Dataset/train/y_train.txt")
trainDataSubject <- read.table("./Dataset/train/subject_train.txt")

testData  <- read.table("./Dataset/test/X_test.txt")
testDataActivity  <- read.table("./Dataset/test/y_test.txt")
testDataSubject  <- read.table("./Dataset/test/subject_test.txt")

activityLabels <- read.table("./Dataset/activity_labels.txt")
features <- read.table("./Dataset/features.txt")


# --------------------------------------------------------------
# Add column headers
featureNames <- features[,"V2"]
colnames(trainData) <- featureNames
colnames(testData) <- featureNames


# --------------------------------------------------------------
# Merge the datasets
trainData$Activity <- as.numeric(trainDataActivity$V1)
trainData$Subject <- as.numeric(trainDataSubject$V1)

testData$Activity <- as.numeric(testDataActivity$V1)
testData$Subject <- as.numeric(testDataSubject$V1)

fullData <- rbind(trainData, testData)


# --------------------------------------------------------------
# Subsititue activity values
fullData$Activity <- gsub("1", "WALKING", fullData$Activity)
fullData$Activity <- gsub("2", "WALKING_UPSTAIRS", fullData$Activity)
fullData$Activity <- gsub("3", "WALKING_DOWNSTAIRS", fullData$Activity)
fullData$Activity <- gsub("4", "SITTING", fullData$Activity)
fullData$Activity <- gsub("5", "STANDING", fullData$Activity)
fullData$Activity <- gsub("6", "LAYING", fullData$Activity)


# --------------------------------------------------------------
# Select columns 
meanData <- fullData[, grep("mean\\(", colnames(fullData))]
stdData <- fullData[, grep("std\\(", colnames(fullData))]
finalData <- cbind(meanData, stdData)
finalData$Subject <- fullData$Subject
finalData$Activity <- fullData$Activity

# ---------------------------------------------------------------
# Create new data.set 
newData <- summarise_each(group_by(finalData, Subject, Activity), funs(mean))


# ---------------------------------------------------------------
# Rename columns names
n <- names(newData)
n <- gsub("\\(\\)-", "", n)
n <- gsub("\\(\\)", "", n)
n <- gsub("Acc", "Accelaration", n)
n <- gsub("std", "StandardDeviation", n)
n[3:68] <- substring(n[3:68], 2)
colnames(newData) <- n


# ---------------------------------------------------------------
# Save data.set
write.table(newData, file="./Result.txt", row.names=FALSE) 



