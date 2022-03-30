# OHF_example
A script designed to process opinion survey data and produce graphs and analytics in an HTML output

## Project description
A short presentation which takes the results from a Google forms survey published in .csv format and produces barplots and one analysis example. 

Before it can be used for analysis, the data requires cleaning and quality control, before passing to produce data visuals.

This is a semi-automated workflow that operates though the Knit function in Rmarkdown, this pulls and updates data directly from Google Drive, the current number of respondents and the last time the survey was updates are logged. 

## Data Source

This currently uses a private Google Drive repository to access survey data. This requires an authenticated token from the user, and therefore this pipeline is not directly reproducible from this GitHub repository. However an archived version of the data is included for reference. Note this project was built for a real survey, but data here has been simulated in order to demonstrate the code without providing potentially sensitive data. 

## Requirements

The following R packages - available on CRAN are required to run this pipeline
- googledrive
- googlesheets4
- tidyverse
- stringr
- lubridate
- magrittr
- htmltools
