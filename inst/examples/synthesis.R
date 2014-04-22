
# Raw Data
datA = data.frame(river = c("SAC", "SAC", "AM"), 
                 spp = c("king", "king", "ccho"), 
                 stg = c("smolt", "parr", "smolt"),
                 ct =  c(293L, 410L, 210L))



datB = data.frame(site = c("SAC", "AM", "AM"), 
              species = c("Chinook", "Chinook", "Silver"), 
              smct = c(245L, 511L, 199L),
              pcnt =  c(290L, 408L, 212L))


########################################################
#### Classical integration approach ####################
#######################################################


# Define a lookup table to standardize the factors
spp_name_table <- c("Chinook" = "king", 
                    "Silver" = "coho")
datB[["species"]] <- spp_name_table[datB$species]


## Semantic challenge: recognizing "smct" is really two columns: a "stg" and a "count"
## Break smolt count and parr count to separate tables and merge
smct <- datB[c("site", "species", "smct")]
pcnt <- datB[c("site", "species", "pcnt")]

# Add a column to each indicating the stage, "stg"
smct[["stg"]] <- "smolt"
pcnt[["stg"]] <- "parr"

# Rename the count column (using the name given in datA)
who <- names(smct) 
who[who == "smct"] <- "ct"
names(smct) <- who
names(pcnt) <- who    # "pcnt" als becomes "ct"

# re-combine smolt and parr data.frames 
datB_clean <- rbind(smct,pcnt)



# Rename columns following datA conventions: site->river, species->spp 
col_names_map <- names(datB_clean)
names(col_names_map) <- names(datB_clean)
col_names_map["site"] <- "river"
col_names_map["species"] <- "spp"
names(datB_clean) <- col_names_map[names(datB_clean)]



# Append column indicating source dataset
datB_clean[["source"]] <- "B"
datA[["source"]] <- "A"



# Finally, integrate the data sources. 
#datB_clean <- datB_clean[names(datA)] # Reordering isn't needed, rbind does it
dat <- rbind(datA, datB_clean)


#########################################################


# Metadata 
datA <- data.set(datA,
                 col.defs = c("http://dbpedia.org/ontology/River",
                              "http://dbpedia.org/ontology/Species", 
                              "Life history stage",
                              "count"),
                 unit.defs = 
                   list(c(SAC = "The Sacramento River", AM = "The American River"),
                        c(king = "King Salmon", ccho = "Coho Salmon"),
                        c(parr = "third life stage", smolt = "fourth life stage"),
                        "number")
                )


datB <- data.set(datB,
                 col.defs = c(site = "http://dbpedia.org/ontology/River",
                              species = "http://dbpedia.org/ontology/Species", 
                              smct = "Smolt count",
                              pcnt = "Parr count").
 
                 unit.defs = 
                   list(c(SAC = "The Sacramento River", AM = "The American River"),
                        c(Chinook = "King Salmon", Silver = "Coho Salmon"),
                        "number",
                        "number")
                 )



# Create maps between descriptions and and column headings
# Check units, create maps between factors and definitions
# Detect and handle the smct pcnt issue

