## Small test case
# who <- list("creator", "individualName", "contact", "dataTable")
# names(who) <- who
# construct <- lapply(who, template_constructor)

options("emld_db" = "eml-2.1.1")
## Full database
db <- purrr::compact(
  jsonlite::read_json("https://raw.githubusercontent.com/cboettig/emld/master/data-raw/eml_db.json")
)
db["UrlType"] <- NULL # 'function' as argument, not needed
db["url"] <- NULL
who <- names(db)
writeLines(who, "inst/extdata/complexTypes.txt")


# who <- readLines(system.file("extdata/complexTypes.txt", package="EML"))
names(who) <- who
eml <- lapply(who, EML:::template_constructor)


devtools::use_data(eml, overwrite = TRUE)
