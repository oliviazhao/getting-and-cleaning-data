# Codebook
The analysis generates an output file tidy.txt. The data includes all records from training data and test data in the activity recognition datasets.

The analysis follows the steps below:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Raw data to Tidy data
The raw dataset was created using the following regular expression to filter out the mean and standard deviation for each measurement
```javascript
-mean\\(\\)|-std\\(\\)
```
This regular expression selects 66 features from the original dataset. Adding the column subject and activity, this makes up to 68 variables of the first version processed dataset.

Then the analysis adds the activity labels to the first version processed dataset and gets a data frame with 69 variables.

To get the tidy dataset, the analysis calculates aggregated means by subject, activity and activity labels. The variables are named by feature names without change. A sample of variable names are:
```javascript
 [1] "activity"                    "activity_label"              "subject"                    
 [4] "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"           "tBodyAcc-mean()-Z"          
 [7] "tBodyAcc-std()-X"            "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"  
 ```