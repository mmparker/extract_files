library(dplyr)
library(rvest)


files_to_process <- list.files('r:/shared documents/', 
                               pattern = 'html', 
                               full.names = TRUE)



software_info_all <- lapply(files_to_process, FUN = function(this_file) {
    
    print(paste("Extracting data from", this_file))
    
    # Delete the "Software Inventory" multi-column header
    this_file_parsed <- readLines(this_file) %>% 
        .[!grepl(x = ., pattern = "Software Inventory")] %>%
        paste(collapse = "") %>%
        read_html()
    
    # Extract data
    software_inventory <- this_file_parsed %>% 
        html_node("#softwareInventory") %>% 
        html_table(header = TRUE)
    
    machine_info <- this_file_parsed %>% 
        html_node("#machineInfo") %>% 
        html_table(header = TRUE)
    
    report_datetime <- this_file_parsed %>% 
        html_node("#dateTime") %>%
        html_text()
    
    
    # Add software inventory 
    software_inventory['Workstation Name'] <- machine_info['Workstation Name:']
    software_inventory['Logon Credentials'] <- machine_info['Logon Credentials:']
    software_inventory['Report Datetime'] <- report_datetime
    
    extracted_table
    
}) %>% bind_rows()




#write.csv(software_info_all, file = output_path)
