## Script merges the train and test HAR datasets, sets column names according to 
## features list, extracts only mean and std for each measurement, assigns 
##descriptive labels for activities, and creates a new independent tidy dataset

# Load dyplr package
library(dplyr)

# Merge training and test sets for X, y and subject datasets
X_full <- rbind(X_train, X_test)
y_full <- rbind(y_train, y_test)
subject_full <- rbind(subject_train, subject_test)

# Assign feature names to X_full
colnames(X_full) <- features$V2

# Map descriptive ActivityName labels, drop activity numeric values in y_full
y_full$ActivityName <- activity_labels$V2[match(y_full$V1, activity_labels$V1)]
y_full <- y_full %>% select(-V1)

# Rename subject_full column to "Subject"
colnames(subject_full)[colnames(subject_full) == "V1"] <- "Subject"

# Extract mean and std for each measurement into new df
mean_std_columns <- grep("mean\\(\\)|std\\(\\)", colnames(X_full))
X_full_std_mean <- X_full[ , mean_std_columns]

# Merge X, y and subject dfs into single dataset
df_full_std_mean <- cbind(X_full_std_mean, y_full)
df_full_std_mean <- cbind(df_full_std_mean, subject_full)

# Creates new independent tidy dataset with ave of variables per activity/subject
df_ave <- df_full_std_mean %>%
        group_by(Subject, ActivityName) %>%
        summarize(across(where(is.numeric), \(x) mean(x, na.rm = TRUE)))