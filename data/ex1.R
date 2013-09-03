dat = data.frame(river = c("SAC",  "SAC",   "AM"),
                 spp   = c("king",  "king", "ccho"),
                 stg   = c("smolt", "parr", "smolt"),
                 ct    = c(293L,    410L,    210L))
metadata <- 
  list("river" = list("river",
                      "River site used for collection",
                      c(SAC = "The Sacramento River", 
                        AM = "The American River")),
       "spp" = list("spp",
                    "Species common name", 
                    c(king = "King Salmon", 
                      ccho = "Coho Salmon")),
       "stg" = list("stg",
                    "Life Stage", 
                    c(parr = "third life stage", 
                      smolt = "fourth life stage")),
       "ct"  = list("ct",
                    "count", 
                    "number"))



