
library(dplyr)
library(rvest)

files_to_process <- list.files('r:/shared documents/', 
                               pattern = 'html', 
                               full.names = TRUE)


# Check that these are the right file paths
files_to_process

this_file <- files_to_process[1]


# Delete the "Software Inventory" multi-column header
this_file_parsed <- readLines(this_file) %>% 
    .[!grepl(x = ., pattern = "Software Inventory")] %>%
    paste(collapse = "") %>%
    read_html(header = TRUE)

software_inventory <- this_file_parsed %>% 
    html_node("#softwareInventory") %>% 
    html_table()

sort(unique(software_inventory['Date Installed']))


