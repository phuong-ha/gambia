################################################################################
## Code: 2018-04-15_test.R
## Description: Test
## Author: phuongha
## Created date: 2018-04-15
## Updated date: 2018-04-15
################################################################################


## -----------------------------------------------------------------------------
## SET UP
## -----------------------------------------------------------------------------

## global variables
params <- new.env(parent = emptyenv())
params$username <- '$$FilterValue::get_user_info("##USERNAME##","username")$$'
params$userrole <- '$$FilterValue::get_user_info(FilterValue::get_user_info("##USERNAME##","username"), "user_role")$$'
params$fullname <- '$$FilterValue::get_user_info(FilterValue::get_user_info("##USERNAME##","username"), "fullname")$$'
params$projcode <- '$$FilterValue::get_my_projectcode()$$'

## global setup
Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")
options(scipen = 999)

## load packages
RTA::load_packages(readr, tidyr, dplyr, RTA)

# ## import data
# auto_import_all(site = params$projcode)


## -----------------------------------------------------------------------------
## HELPER FUNCTIONS
## -----------------------------------------------------------------------------
get_installed_packages <- function() {
    pkgs <- installed.packages()
    pkgs <- as.data.frame.matrix(pkgs, row.names = FALSE,
                                 stringsAsFactors = FALSE)
    pkgs <- pkgs[, c("Package", "Version", "Imports")]
    pkgs
}

get_sessionInfo <- function() {
    sinfo <- sessionInfo()
    out <- data.frame(
        platform = sinfo$platform,
        os = sinfo$running,
        r_version = sinfo$R.version$version.string,
        stringsAsFactors = FALSE
    )
    out
}

pkgs <- get_installed_packages()
sinfo <- get_sessionInfo()
result <- cbind(pkgs, sinfo)

if (interactive()) {
    ## Check data to look for possible errors
    DT::datatable(result)
} else {
    ## Remove unnecessary objects
    rm(list = setdiff(ls(), "result"))

    ## Export to JSON format
    if(nrow(result)) result[] <- lapply(result, as.character)
    result <- rbind(colnames(result), result)
    jsonlite::toJSON(result, dataframe = 'values')
}

