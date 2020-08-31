
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


machine_info <- this_file_parsed %>% 
    html_node("#machineInfo") %>% 
    html_table(header = FALSE)



# Does this print just the Workstation Name?
machine_info[ grepl(x = machine_info[ , 1], pattern = 'Workstation Name'), 2]
                                 

machine_info[ grepl(x = machine_info[ , 1], pattern = 'Logon'), 2]



