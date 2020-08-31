library(dplyr)
library(rvest)


files_to_process <- list.files('r:/shared documents/', 
                               pattern = 'html', 
                               full.names = TRUE)



software_inventory_all <- lapply(files_to_process, FUN = function(this_file) {
    
    print(paste("Extracting data from", this_file))
    
    # Delete the "Software Inventory" multi-column header
    this_file_parsed <- readLines(this_file) %>% 
        .[!grepl(x = ., pattern = "Software Inventory")] %>%
        paste(collapse = "") %>%
        read_html()
    
    # Print each 
    machine_info <- this_file_parsed %>% 
        html_node("#machineInfo") %>% 
        html_table(header = TRUE)
  
    print(paste0("Machine info table from file ", this_file)) 
  
    print(machine_info)
    
})

