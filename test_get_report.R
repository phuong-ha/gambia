##START_HERE

#* @get /getReport
#* @html
getReport <- function(site, report_id, filename, params) {
    if (missing(site)) {
        stop("argument 'site' is missing, with no default", call. = FALSE)
    }

    if (missing(report_id)) {
        stop("argument 'report_id' is missing, with no default", call. = FALSE)
    }

    if (missing(filename)) filename <- "report.html"

    if (missing(params)) params <- list()

    create_report_url <- function(site, report_id) {
        paste0(RTA::get_project_url(site), "/markdown/", report_id, "/rmd_files/mdscript.Rmd")
    }

    rmd <- create_report_url(site = site, report_id = report_id)
    temp_report <- file.path(tempdir(), "report1.Rmd")
    curl::curl_download(rmd, temp_report)
    output_file <- rmarkdown::render(
        temp_report,
        output_file = "/home/phuongha/MEGAsync/RTA/Analytic/gambia/report.html",
        envir = new.env(parent = globalenv())
    )
    readBin(output_file, "raw", file.info(output_file)$size)
}

##END_HERE
