setwd("./UCI HAR Dataset")
## 1.Merges the training and the test sets to create one data set
subject.test <- read.table("./test/subject_test.txt")
subject.train <- read.table("./train/subject_train.txt")
subject <- rbind(subject.test,subject.train)

body.acc.x.test <- read.table("./test/Inertial\ Signals/body_acc_x_test.txt")
body.acc.x.train <- read.table("./train/Inertial\ Signals/body_acc_x_train.txt")
body.acc.x <- rbind(body.acc.x.test,body.acc.x.train)

body.acc.y.test <- read.table("./test/Inertial\ Signals/body_acc_y_test.txt")
body.acc.y.train <- read.table("./train/Inertial\ Signals/body_acc_y_train.txt")
body.acc.y <- rbind(body.acc.y.test,body.acc.y.train)

body.acc.z.test <- read.table("./test/Inertial\ Signals/body_acc_z_test.txt")
body.acc.z.train <- read.table("./train/Inertial\ Signals/body_acc_z_train.txt")
body.acc.z <- rbind(body.acc.z.test,body.acc.z.train)

body.gyro.x.test <- read.table("./test/Inertial\ Signals/body_gyro_x_test.txt")
body.gyro.x.train <- read.table("./train/Inertial\ Signals/body_gyro_x_train.txt")
body.gyro.x <- rbind(body.gyro.x.test,body.gyro.x.train)

body.gyro.y.test <- read.table("./test/Inertial\ Signals/body_gyro_y_test.txt")
body.gyro.y.train <- read.table("./train/Inertial\ Signals/body_gyro_y_train.txt")
body.gyro.y <- rbind(body.gyro.y.test,body.gyro.y.train)

body.gyro.z.test <- read.table("./test/Inertial\ Signals/body_gyro_z_test.txt")
body.gyro.z.train <- read.table("./train/Inertial\ Signals/body_gyro_z_train.txt")
body.gyro.z <- rbind(body.gyro.z.test,body.gyro.z.train)

total.acc.x.test <- read.table("./test/Inertial\ Signals/total_acc_x_test.txt")
total.acc.x.train <- read.table("./train/Inertial\ Signals/total_acc_x_train.txt")
total.acc.x <- rbind(total.acc.x.test,total.acc.x.train)

total.acc.y.test <- read.table("./test/Inertial\ Signals/total_acc_y_test.txt")
total.acc.y.train <- read.table("./train/Inertial\ Signals/total_acc_y_train.txt")
total.acc.y <- rbind(total.acc.y.test,total.acc.y.train)

total.acc.z.test <- read.table("./test/Inertial\ Signals/total_acc_z_test.txt")
total.acc.z.train <- read.table("./train/Inertial\ Signals/total_acc_z_train.txt")
total.acc.z <- rbind(total.acc.z.test,total.acc.z.train)

x.test <- read.table("./test/X_test.txt")
x.train <- read.table("./train/X_train.txt")
x <- rbind(x.test,x.train)

y.test <- read.table("./test/y_test.txt")
y.train <- read.table("./train/y_train.txt")
y <- rbind(y.test,y.train)

## 2.Extracts only the measurements on the mean and standard deviation for each measurement.
body.acc.x.mean <- apply(body.acc.x,2,mean)
body.acc.y.mean <- apply(body.acc.y,2,mean)
body.acc.z.mean <- apply(body.acc.z,2,mean)
body.gyro.x.mean <- apply(body.gyro.x,2,mean)
body.gyro.y.mean <- apply(body.gyro.y,2,mean)
body.gyro.z.mean <- apply(body.gyro.z,2,mean)
total.acc.x.mean <- apply(total.acc.x,2,mean)
total.acc.y.mean <- apply(total.acc.y,2,mean)
total.acc.z.mean <- apply(total.acc.z,2,mean)

body.acc.x.sd <- apply(body.acc.x,2,sd)
body.acc.y.sd <- apply(body.acc.y,2,sd)
body.acc.z.sd <- apply(body.acc.z,2,sd)
body.gyro.x.sd <- apply(body.gyro.x,2,sd)
body.gyro.y.sd <- apply(body.gyro.y,2,sd)
body.gyro.z.sd <- apply(body.gyro.z,2,sd)
total.acc.x.sd <- apply(total.acc.x,2,sd)
total.acc.y.sd <- apply(total.acc.y,2,sd)
total.acc.z.sd <- apply(total.acc.z,2,sd)

## 3.Uses descriptive activity names to name the activities in the data set
activity.labels <- read.table("activity_labels.txt")
names(activity.labels) <- c("id","labels")
y.labels <- rep(activity.labels[1,]$labels,nrow(y))
for(idx in 2:nrow(activity.labels)) y.labels[y==activity.labels[idx,1]] <- activity.labels[idx,2]
y <- y.labels

## 4.Appropriately labels the data set with descriptive variable names.
features <- read.table("features.txt")
names(x) <- as.vector(features[,2])

## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
x.mean.group.by.label <- aggregate(x,by=list(y.label=y,subject.label=subject[,1]),mean)
