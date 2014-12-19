# Fetch the data and find the right working directory.
setwd("/R_data/")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "dataset.zip", mode="wb")
unzip("dataset.zip")
setwd("/R_data/UCI HAR Dataset")
