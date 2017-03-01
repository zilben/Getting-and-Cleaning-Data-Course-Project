library(reshape2)

wd <- "C:/Users/lsanchez/Desktop/Coursera Data Science/Course 3 Data Cleansing Prep/AssignmentW4"

#######################
## Download/unzip data
#######################

setwd(wd)
zipFile <- "getdata_projectfiles_UCI HAR Dataset.zip"

if (!file.exists(zipFile)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, zipFile, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(zipFile) 
}

###################################
# Load activity labels and features
###################################

activity <- read.table("UCI HAR Dataset/activity_labels.txt")
activity[,2] <- as.character(activity[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

#####################################
# Extract mean and std. dev. features
#####################################

features2 <- grep(".*mean.*|.*std.*", features[,2])
features2.names <- features[features2,2]
features2.names = gsub('-mean', 'Mean', features2.names)
features2.names = gsub('-std', 'Std', features2.names)
features2.names <- gsub('[-()]', '', features2.names)

###########################################################
# Load test/train data and add activity and subject columns
###########################################################

train <- read.table("UCI HAR Dataset/train/X_train.txt")[features2]
trainActivity <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubject, trainActivity, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[features2]
testActivity <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubject, testActivity, test)

######################################
# merge train/test data and add labels
######################################

fData <- rbind(train, test)
colnames(fData) <- c("subject", "activity", features2.names)

############################################
# turn subject/activity columns into factors
############################################
fData$activity <- factor(fData$activity, levels = activity[,1], labels = activity[,2])
fData$subject <- as.factor(fData$subject)

##########################################################
# write tidy data file with means per subject and activity
##########################################################

fData.melted <- melt(fData, id = c("subject", "activity"))
fData.mean <- dcast(fData.melted, subject + activity ~ variable, mean)

write.table(fData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
