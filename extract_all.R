
library(dplyr)
library(rvest)


files_to_process <- list.files('r:/shared documents/', 
                               pattern = 'html', 
                               full.names = TRUE)



extracted_tables <- lapply(files_to_process, FUN = function(this_file) {
    
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
    software_inventory$machine_name <- machine_info$machine_name
    software_inventory$login_name <- machine_info$login_name
    software_inventory$report_datetime <- report_datetime
    
    
    # Write out with the name of the HTML file
    output_path <- sub(x = basename(this_file), pattern = ".html", replacement = ".csv")
    
    print(paste("Writing extracted data to", output_path))
    write.csv(renamed_table, file = output_path)
    
    extracted_table
    
})



# Quick check of the first few rows to make sure every table is looking good
lapply(extracted_tables, head)







