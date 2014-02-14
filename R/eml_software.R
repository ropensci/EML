
r_package <- function(packagename){
  info <- packageDescription(packagename)
  a$Package          a$Version          a$BugReports       a$VignetteBuilder  a$Depends          a$Author           
  a$Description      a$License          a$Date             a$Suggests         a$Collate          a$Maintainer       
  a$Title            a$URL              a$Authors@R        a$Imports          a$Packaged         a$Built   

  cre <- eval(parse(text = info[["Authors@R"]]))
  cre <- new("ListOfCreator", lapply(cre, as, "creator")) 

  ## Find out if distribution is via CRAN, Github, etc
  distribution = new("distribution", new("online", url = info$URL))

  
  deps <- strsplit(paste(info$Imports, info$Depends, sep=", "), ", ")
  depends <- new("ListOfdependency", 
                 lapply(deps, function(dep) 
                        new("dependency", software = dep)))
  implement <- new("implementation", distribution = distribution)

  new("software",
      shortName = info$Package,
      title = info$Title,
      pubdate = info$Date,
      abstract = info$Description,
      creator = cre,
      license = info$License,
      version = info$Version,
      implementation = implement,
      dependency = depends)
}
