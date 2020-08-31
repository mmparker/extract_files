
library(dplyr)
library(rvest)


input_directory <- 'r:/shared documents/'
output_directory <- getwd()


files_to_process <- list.files(, 
                               pattern = 'html', 
                               full.names = TRUE)


# Check that these are the right file paths
files_to_process

this_file <- files_to_process[1]


# Delete the "Software Inventory" multi-column header
this_file_parsed <- readLines(this_file) %>% 
    .[!grepl(x = ., pattern = "Software Inventory")] %>%
    paste(collapse = "") %>%
    read_html()


software_inventory <- this_file_parsed %>% 
    html_node("#softwareInventory") %>% 
    html_table(header = TRUE)

str(software_inventory)


