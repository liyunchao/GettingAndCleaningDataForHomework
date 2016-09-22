setwd("./UCI HAR Dataset")
## 1.Merges the training and the test sets to create one data set
subject.test <- read.table("./test/subject_test.txt")
subject.train <- read.table("./train/subject_train.txt")
subject <- rbind(subject.test,subject.train)

x.test <- read.table("./test/X_test.txt")
x.train <- read.table("./train/X_train.txt")
x <- rbind(x.test,x.train)

y.test <- read.table("./test/y_test.txt")
y.train <- read.table("./train/y_train.txt")
y <- rbind(y.test,y.train)

## 2.Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("features.txt")
col.idx <- grep("-mean()|-std()",features[,2])

## 3.Uses descriptive activity names to name the activities in the data set
activity.labels <- read.table("activity_labels.txt")
names(activity.labels) <- c("id","labels")
y.labels <- rep(activity.labels[1,]$labels,nrow(y))
for(idx in 2:nrow(activity.labels)) y.labels[y==activity.labels[idx,1]] <- activity.labels[idx,2]
y <- y.labels

## 4.Appropriately labels the data set with descriptive variable names.
names(x) <- as.vector(features[,2])
target.x <- x[,col.idx]

## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
x.mean.group.by.label <- aggregate(target.x,by=list(y.label=y,subject.label=subject[,1]),mean)
write.table(x.mean.group.by.label,"x_mean_group_by_label.txt",row.names=F)