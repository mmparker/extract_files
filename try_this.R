
library(dplyr)
library(rvest)

files_to_process <- list.files('r:/shared documents/', 
                               pattern = 'html', 
                               full.names = TRUE)


this_file <- files_to_process[1]

this_file_parsed <- readLines(this_file) %>% 
    .[!grepl(x = ., pattern = "Software Inventory")] %>%
    paste(collapse = "") %>%
    read_html(header = TRUE)

software_inventory <- this_file_parsed %>% 
    html_node("#softwareInventory") %>% 
    html_table()

names(software_inventory)
#sort(unique(software_inventory['Date Installed']))


