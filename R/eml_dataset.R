
eml_dataset <- 
  function(dat = NULL,
           title = "EML_metadata",
           creator = NULL, 
           contact = NULL, 
           coverage = eml_coverage(scientific_names = NULL,
                                   dates = NULL,
                                   geographic_description = NULL,
                                   NSEWbox = NULL),
           methods = new("methods"),
           col.defs = NULL,
           unit.defs = NULL,
           col.classes = NULL, 
           ref_id = eml_id(),
           ...){

  if(is.null(creator))
    creator <- get("defaultCreator", envir=EMLConfig)
  if(is.null(contact))
    contact <- get("defaultContact", envir=EMLConfig)

  ## Coerce character string persons into EML representations
  if(!is.null(dat)) # this is written only into dataset nodes 
    who <- contact_creator(contact = contact, 
                           creator = creator)

  ## Format methods appropriately 
  if(is(methods, "character")){
    methods <- new("methods", 
                   methodStep = c(new("methodStep", 
                                      description = methods)))
  }

  if(is(dat, "dataset")){ # pre-built dataset object
    dataset <- dat 

  } else if(is(dat, "data.frame") || is(dat, "character")){  # data.set class, 

    dataset = new("dataset",
                  id = ref_id[["id"]],
                  title = title, # required 
                  creator = who$creator,
                  contact = who$contact,
                  coverage = coverage,
                  methods = methods, 
                  dataTable = c(eml_dataTable(dat = dat,
                                              col.defs = col.defs,
                                              unit.defs = unit.defs,
                                              col.classes = col.classes)),
                  ...)


  } else if(is(dat, "dataTable")){

    dataset = new("dataset",
                  id = ref_id[["id"]],
                  title = title, # required 
                  creator = who$creator,
                  contact = who$contact,
                  coverage = coverage,
                  methods = methods, 
                  dataTable = c(dat),
                  ...)
  } else if(is(dat, "ListOfdataTable")) {
    dataset = new("dataset",
                  id = ref_id[["id"]],
                  title = title, # required 
                  creator = who$creator,
                  contact = who$contact,
                  coverage = coverage,
                  methods = methods, 
                  dataTable = dat,
                  ...)
  }
  dataset
}


