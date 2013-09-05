 
## Replace description definitions with GIDs (linked data urls...?)

dat2 <- data.frame(site = c("SAC", "AM", "AM"), 
                   species = c("Chinook", "Chinook", "Silver"), 
                   smct = c(245L, 511L, 199L),
                   pcnt =  c(290L, 408L, 212L))

metadata2 <- list(list('river', 'A large river',  c(SAC = "The Sacramento River", AM = "The American River")),
                 list('spp', 'species common name', c(Chinook = "King Salmon", Silver = "Coho Salmon"),
                 list('smct', 'smolt count', "number"),
                 list('pcnt', 'parr count', "number"))


dat1 <- data.frame(river=c("SAC", "SAC", "AM"),
                        spp = c("king", "king", "ccho"),
                        stg = c("smolt", "parr", "smolt"),
                        ct =  c(293L, 410L, 210L))

metadata1 <- 
  list(list("river", "River site used for collection", c(SAC = "The Sacramento River", AM = "The American River")),
       list("spp", "Species common name", c(king = "King Salmon",  ccho = "Coho Salmon")),
       list("stg", "Life Stage",  c(parr = "third life stage", smolt = "fourth life stage")),
       list("ct",  "count", "number"))
    



## Define a function that plots lats and longs from datatables using the column description.  
