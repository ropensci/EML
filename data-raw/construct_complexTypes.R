## Small test case
# who <- list("creator", "individualName", "contact", "dataTable")
# names(who) <- who
# construct <- lapply(who, template_constructor)

# Building the constructors for more than one version is not supported yet so
# we just build them for EML 2.2.0. See
# https://github.com/ropensci/EML/issues/287 for more info.
options("emld_db" = "eml-2.2.0")

## Full database
db <- purrr::compact(
  jsonlite::read_json(paste0("https://raw.githubusercontent.com/ropensci/emld/",
                             "master/data-raw/", getOption("emld_db"), ".json"))
)
db["UrlType"] <- NULL # 'function' as argument, not needed
db["url"] <- NULL
who <- names(db)
writeLines(who, "inst/extdata/complexTypes.txt")


who <- readLines(system.file("extdata/complexTypes.txt", package="EML"))
names(who) <- who
eml <- lapply(who, template_constructor)

usethis::use_data(eml, overwrite = TRUE)
