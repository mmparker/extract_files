


report_datetimes <- c("(Generated: 10/30/2020 10:24:23 PM)",
                      "(Generated: 1/1/2020 1:24:23 PM)",
                      "(Generated: 1/1/2020 1:24:23 AM)")



# One way: convert it directly to a POSIXct timestamp
as.POSIXct(report_datetimes, format = "(Generated: %m/%d/%Y %I:%M:%S %p)")


# Or just leave it as a string, if you prefer this date format
sub(x = report_datetimes,
    pattern = ".Generated: (\\d*/\\d*/\\d* \\d*:\\d*:\\d* \\w\\w).",
    replacement = "\\1")
           

