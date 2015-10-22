# Description af run_analysis file
This file will describe the analysis flow in the run_analysis.r file

### Load libraries and prepare
Line 1- 9 prepares the environment on loading the relevant packages and set the working directory

### Load data from flat-files
Line 10-23 loads raw data from the .txt files into data frames - this includes both the training data, test data and some files which describes the activity codes and features.

### Name the columns
The second row of the Feature-data set is extracted and then added to both the training and test set. After this step the columns is named with relevant names

### Merge datasets
Joins the type of activity and the subject onto each row of the datasets. Then merge training and test datasets by binding the rows. The new dataset is named 'fullData'

### Substitute activity with text
Substitute the numeric codes for activity into strings ex. Walking, sitting, laying etc.

### Shrink dataset
Select only the columns where the words 'mean' and 'std' - bind the new columns into a new dataframe named 'finalData'

### Summarize data
Summarize the data, where we group the data foreach subject and next foreach activity. Based on that grouping we calculate the mean values for all the measurements. Data is saved in new dataframe named newData

### Make readable columns
This sections substitues a series of acronyms into real wording using substition

### Save Data
The resulting newData dataset is stored into and .txt file
