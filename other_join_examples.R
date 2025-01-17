# SET-UP ------------------------------------------------------------------
# Load packages for reading xlsx files 
library(readxl)

# READ IN DATA FROM XLSX SHEETS -------------------------------------------
# Import dataset (table) with two id numbers variable (each participant has 2 id's)
id_df <- read_xlsx("sample_data.xlsx", sheet = 1)

# Import dataset (table) with id, sleep, and, name details
sleep_df <- read_xlsx("sample_data.xlsx", sheet = 2)

# Import dataset (table) with names and coffee information 
coffee_df <- read_xlsx("sample_data.xlsx", sheet = 3)

# Import dataset (table) with names and coffee information 
loveid529_df <- read_xlsx("sample_data.xlsx", sheet = 4)


# LOOK AT DATSETS ---------------------------------------------------------
# Print each dataset to console to inspect contents
id_df           # id's
sleep_df        # sleep data (id, first, and last name)
coffee_df       # coffee data (no id var, but first and last (different last_name var name))
loveid529_df   # loves ID 529? (has id2_num)

# LINK TOGETHER ALL DATASETS, BUT ONLY KEEP TEACHING TEAM MEMBERS--------

# Using the identifying information we have, which varies across each table, we want to 
# link each of 4 datasets together, keeping only the ID 529 teaching team members. 
# The resulting dataset should include:
# 4 rows x 7 columns 

# Simply join id_df to sleep_df by the shared 'id_num' variable
right_join(x = id_df, y = sleep_df, by = "id_num") |>
  # THEN join this updated dataset to the coffee dataset, considering the available 
  # identifiers (e.g., first and last name)
  left_join(x = _, y = coffee_df, by = c("first_name", "last_name" = "LAST")) |> 
  # THEN join that updated dataset to the the "i<3 id529 dataset by the secondary ID number.
  left_join(x = _, y = loveid529_df, by = c("id2_num" = "id2"))
  
