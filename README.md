# wearable-data-merging
John Hopkins Getting and Cleaning Data course project github repository

## The Script - run_analysis.R
The script run_analysis.R contains all the steps to create tidy data into working directory. This script uses dplyr library and it is checked in a code that user has it. The data from which the tidy data is created needs to be in the working directory. The script will warn if the necassery files are not found. It is still users responsibility to make them available.
The script will check that files are found. It will read features into memory and use them to label train and test sets. Both sets are compined with the acitivityId and subject for each measurement. Script will then combine the train and test data and remove the train and test data replicates from memory. 
From this combined data set, only mean, standart deviation, activity id and subject columns are selected. The activity id is replaced with activity label.
From here the tidy data is created with library dplyr. The tidy data groups the subject and activity class and averages the measurements over them. This tidy data is then written into the working directory into a file called tidy_data.txt. This will be prompted.
In short
* Read test and train data
* Add needed columns to these data
* Combine test and train data into one data
* Select needed columns
* Add labels to data where available
* Create summary data set with grouping and averaging
* Write tidy data output file

## The tidy data file output
The output file information can be found in the repository file called codebook.txt. Also information about the original data is found in this file.
