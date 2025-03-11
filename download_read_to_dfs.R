## Script downloads HAR dataset directories and reads X, y, subject and features
## files to data frames

# Set ZIP url
zip_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# Temp file to store ZIP
temp_file <- tempfile(fileext = ".zip")
# Download the ZIP file
download.file(zip_url, destfile = temp_file, mode = "wb")
# Extract the ZIP file into the current working directory
unzip(temp_file, exdir = getwd())

# Specify directory path to train/test files
train_path <- "/Users/suzukikanako/Documents/R programming/Rprog/UCI HAR Dataset/train"
test_path <- "/Users/suzukikanako/Documents/R programming/Rprog/UCI HAR Dataset/test"

# List all .txt files in the directory
train_txt_files <- list.files(train_path, pattern = "\\.txt$", full.names = TRUE)
test_txt_files <- list.files(test_path, pattern = "\\.txt$", full.names = TRUE)

# Extract file names
train_file_names <- tools::file_path_sans_ext(basename(train_txt_files))
test_file_names <- tools::file_path_sans_ext(basename(test_txt_files))

# Read inertia files and assign to data frames
train_data_list <- setNames(lapply(train_txt_files, read.table), train_file_names)
test_data_list <- setNames(lapply(test_txt_files, read.table), test_file_names)

# Assign each list element to an individual data frame in the global environment
list2env(train_data_list, envir = .GlobalEnv)
list2env(test_data_list, envir = .GlobalEnv)

# Read features and activity labels txt files to dfs
HAR_path_features <- "/Users/suzukikanako/Documents/R programming/Rprog/UCI HAR Dataset/features.txt"
features <- read.table(HAR_path_features, header = FALSE, sep = "", stringsAsFactors = FALSE)
HAR_path_activities <- "/Users/suzukikanako/Documents/R programming/Rprog/UCI HAR Dataset/activity_labels.txt"
activity_labels <- read.table(HAR_path_activities, header = FALSE, sep = "", stringsAsFactors = FALSE)
        
# Remove data lists
rm(test_data_list)
rm(train_data_list)