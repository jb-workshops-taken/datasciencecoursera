Cleanup Process in run_analysis.R
0. (In fetchdata.R) Retrieves zip file, unzips it, sets working directory.  Assuming you already have the data, and you have already set your working directory inside the UHC directory, you can skip this step.  Made as a separate script since download only has to be done once and it's slow.
1. Read in all data files.  Nothing tricky here.
2. Columns were originally separate: subject identity, activity identity, measurement values. First step was to combine those into a single set of columns for each of (test, training).   Assumed: values were in a matching order within the individual files, so as long as  sort order was not changed, columns would directly match.  Since no id values were provided, this seemed to be the only way the matching could work.
3. Next I improved column names, pulling information from features.txt for the measurement columns. Cleaned up BodyBody column names to just Body.  Removed punctuation to get valid column names. Named subject and activity id columns manually.
4. This left one set of test data and another set of training data, both with exactly the same column names and number of columns.  At that point, I combined  the two data sets as a single data set, using rbind since they simply added more observations to an already well-structured set.
5. Then I extracted just the column names for mean and standard deviation (plus subject and activity, as we always need those).  Taking a strict definition of what was requested for mean, I chose to exclude the meanFreq columns from this set.  To change this behavior, modify the R script, as indicated by the comment near line 45, to comment out the exclusion filter.  I then filtered from "alldata" to "importantdata" based on this list of column names.
6. I joined in the names for the activities, matching on activity id.  The useful data frame at this point is "namedactivities" and its list of columns was already limited in the prior step.
7. I created a new data frame called "averages" which provides the mean for each group (per subject per activity) for that more limited set of columns.  This reduces the rowcount down as it's no longer looking at measurements but instead means of the prior values.  This leaves us with 30 subjects and 6 activities per subject, for a total of 180 rows.
8. Results are saved in "averages.txt" and the list of column names to prep the code book is saved in "fields.txt" then converted by hand to codes.md.

Fields are listed below.  Meanings are based on the meanings in the original data set, with minor cleanup for improved readability.  This describes the data in averages.txt which (as the name might imply) provides the means of the pre-existing fields.  For that reason, every value column name has "mean." prepended.  With this, it would be possible to join this data set from the original data set without inadvertent duplicate column names, if needed for further analysis.


|Field Name|Meaning|
|----------|-------|
|subject|Which test subject performed the action (person)|
|activityname|Name of the activity the subject was performing|
|activityid|ID number of the activity the subject was performing. (All remaining values are means per subject per activity.)|
|mean.tBodyAcc.mean.X|"Mean of the ""time domain signal, body accelaration, mean X"" values"|
|mean.tBodyAcc.mean.Y|"Mean of the ""time domain signal, body accelaration, mean Y"" values"|
|mean.tBodyAcc.mean.Z|"Mean of the ""time domain signal, body accelaration, mean Z"" values"|
|mean.tGravityAcc.mean.X|"Mean of the ""time domain signal, gravity accelaration, mean X"" values"|
|mean.tGravityAcc.mean.Y|"Mean of the ""time domain signal, gravity accelaration, mean Y"" values"|
|mean.tGravityAcc.mean.Z|"Mean of the ""time domain signal, gravity accelaration, mean Z"" values"|
|mean.tBodyAccJerk.mean.X|"Mean of the ""time domain signal, body accelaration jerk calculation, mean X"" values"|
|mean.tBodyAccJerk.mean.Y|"Mean of the ""time domain signal, body accelaration jerk calculation, mean Y"" values"|
|mean.tBodyAccJerk.mean.Z|"Mean of the ""time domain signal, body accelaration jerk calculation, mean Z"" values"|
|mean.tBodyGyro.mean.X|"Mean of the ""time domain signal, body gyroscope, mean X"" values"|
|mean.tBodyGyro.mean.Y|"Mean of the ""time domain signal, body gyroscope, mean Y"" values"|
|mean.tBodyGyro.mean.Z|"Mean of the ""time domain signal, body gyroscope, mean Z"" values"|
|mean.tBodyGyroJerk.mean.X|"Mean of the ""time domain signal, body gyroscope jerk calculation, mean X"" values"|
|mean.tBodyGyroJerk.mean.Y|"Mean of the ""time domain signal, body gyroscope jerk calculation, mean Y"" values"|
|mean.tBodyGyroJerk.mean.Z|"Mean of the ""time domain signal, body gyroscope jerk calculation, mean Z"" values"|
|mean.tBodyAccMag.mean|"Mean of the ""time domain signal, body accelaration magnitude mean"" values"|
|mean.tGravityAccMag.mean|"Mean of the ""time domain signal, gravity accelaration magnitude mean"" values"|
|mean.tBodyAccJerkMag.mean|"Mean of the ""time domain signal, body accelaration jerk magnitude mean"" values"|
|mean.tBodyGyroMag.mean|"Mean of the ""time domain signal, body gyroscope magnitude mean"" values"|
|mean.tBodyGyroJerkMag.mean|"Mean of the ""time domain signal, body gyroscope jerk magnitude mean"" values"|
|mean.fBodyAcc.mean.X|"Mean of the ""frequency domain signal, body accelaration, mean X"" values"|
|mean.fBodyAcc.mean.Y|"Mean of the ""frequency domain signal, body accelaration, mean Y"" values"|
|mean.fBodyAcc.mean.Z|"Mean of the ""frequency domain signal, body accelaration, mean Z"" values"|
|mean.fBodyAccJerk.mean.X|"Mean of the ""frequency domain signal, body accelaration jerk calculation, mean X"" values"|
|mean.fBodyAccJerk.mean.Y|"Mean of the ""frequency domain signal, body accelaration jerk calculation, mean Y"" values"|
|mean.fBodyAccJerk.mean.Z|"Mean of the ""frequency domain signal, body accelaration jerk calculation, mean Z"" values"|
|mean.fBodyGyro.mean.X|"Mean of the ""frequency domain signal, body gyroscope, mean X"" values"|
|mean.fBodyGyro.mean.Y|"Mean of the ""frequency domain signal, body gyroscope, mean Y"" values"|
|mean.fBodyGyro.mean.Z|"Mean of the ""frequency domain signal, body gyroscope, mean Z"" values"|
|mean.fBodyAccMag.mean|"Mean of the ""frequency domain signal, body accelaration magnitude, mean"" values"|
|mean.fBodyAccJerkMag.mean|"Mean of the ""frequency domain signal, body accelaration jerk calculation magnitude, mean"" values"|
|mean.fBodyGyroMag.mean|"Mean of the ""frequency domain signal, body gyroscope magnitude, mean"" values"|
|mean.fBodyGyroJerkMag.mean|"Mean of the ""frequency domain signal, body gyroscope jerk calculation magnitude, mean"" values"|
|mean.tBodyAcc.std.X|"Mean of the ""time domain signal, body accelaration standard deviation X"" values"|
|mean.tBodyAcc.std.Y|"Mean of the ""time domain signal, body accelaration standard deviation Y"" values"|
|mean.tBodyAcc.std.Z|"Mean of the ""time domain signal, body accelaration standard deviation Z"" values"|
|mean.tGravityAcc.std.X|"Mean of the ""time domain signal, gravity accelaration standard deviation X"" values"|
|mean.tGravityAcc.std.Y|"Mean of the ""time domain signal, gravity accelaration standard deviation Y"" values"|
|mean.tGravityAcc.std.Z|"Mean of the ""time domain signal, gravity accelaration standard deviation Z"" values"|
|mean.tBodyAccJerk.std.X|"Mean of the ""time domain signal, body accelaration jerk calculation standard deviation X"" values"|
|mean.tBodyAccJerk.std.Y|"Mean of the ""time domain signal, body accelaration jerk calculation standard deviation Y"" values"|
|mean.tBodyAccJerk.std.Z|"Mean of the ""time domain signal, body accelaration jerk calculation standard deviation Z"" values"|
|mean.tBodyGyro.std.X|"Mean of the ""time domain signal, body gyroscope standard deviation X"" values"|
|mean.tBodyGyro.std.Y|"Mean of the ""time domain signal, body gyroscope standard deviation Y"" values"|
|mean.tBodyGyro.std.Z|"Mean of the ""time domain signal, body gyroscope standard deviation Z"" values"|
|mean.tBodyGyroJerk.std.X|"Mean of the ""time domain signal, body gyroscope jerk calculation standard deviation X"" values"|
|mean.tBodyGyroJerk.std.Y|"Mean of the ""time domain signal, body gyroscope jerk calculation  standard deviation Y"" values"|
|mean.tBodyGyroJerk.std.Z|"Mean of the ""time domain signal, body gyroscope jerk calculation  standard deviation Z"" values"|
|mean.tBodyAccMag.std|"Mean of the ""time domain signal, body accelaration magnitude standard deviation"" values"|
|mean.tGravityAccMag.std|"Mean of the ""time domain signal, gravity accelaration magnitude standard deviation"" values"|
|mean.tBodyAccJerkMag.std|"Mean of the ""time domain signal, body accelaration jerk calculation magnitude standard deviation"" values"|
|mean.tBodyGyroMag.std|"Mean of the ""time domain signal, body gyroscope magnitude standard deviation"" values"|
|mean.tBodyGyroJerkMag.std|"Mean of the ""time domain signal, body gyroscope jerk calculation magnitude standard deviation"" values"|
|mean.fBodyAcc.std.X|"Mean of the ""frequency domain signal, body accelaration standard deviation X"" values"|
|mean.fBodyAcc.std.Y|"Mean of the ""frequency domain signal, body accelaration standard deviation Y"" values"|
|mean.fBodyAcc.std.Z|"Mean of the ""frequency domain signal, body accelaration standard deviation Z"" values"|
|mean.fBodyAccJerk.std.X|"Mean of the ""frequency domain signal, body accelaration jerk calculation standard deviation X"" values"|
|mean.fBodyAccJerk.std.Y|"Mean of the ""frequency domain signal, body accelaration jerk calculation standard deviation Y"" values"|
|mean.fBodyAccJerk.std.Z|"Mean of the ""frequency domain signal, body accelaration jerk calculation standard deviation Z"" values"|
|mean.fBodyGyro.std.X|"Mean of the ""frequency domain signal, body gyroscope standard deviation X"" values"|
|mean.fBodyGyro.std.Y|"Mean of the ""frequency domain signal, body gyroscope standard deviation Y"" values"|
|mean.fBodyGyro.std.Z|"Mean of the ""frequency domain signal, body gyroscope standard deviation Z"" values"|
|mean.fBodyAccMag.std|"Mean of the ""frequency domain signal, body accelaration magnitude, standard deviation"" values"|
|mean.fBodyAccJerkMag.std|"Mean of the ""frequency domain signal, body accelaration jerk calculation magnitude, standard deviation"" values"|
|mean.fBodyGyroMag.std|"Mean of the ""frequency domain signal, body gyroscope magnitude standard deviation"" values"|
|mean.fBodyGyroJerkMag.std|"Mean of the ""frequency domain signal, body gyroscope jerk calculation magnitude standard deviation"" values"|
