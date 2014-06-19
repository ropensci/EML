dat = data.frame(river = c("SAC",  "SAC",   "AM"),
                 spp   = c("king",  "king", "ccho"),
                 stg   = c("smolt", "parr", "smolt"),
                 ct    = c(293L,    410L,    210L))


metadata <-list(
  list("river",
      "River site used for collection",
      c(SAC = "The Sacramento River", 
        AM = "The American River")),
  list("spp",
      "Species common name", 
      c(king = "King Salmon", 
        ccho = "Coho Salmon")),
  list("stg",
      "Life Stage", 
      c(parr = "third life stage", 
        smolt = "fourth life stage")),
  list("ct",
      "count of live fish in traps", 
      "number"))


