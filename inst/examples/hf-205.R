library("eml2")

# Define the metadata shown in "https://raw.githubusercontent.com/ropensci/EML/master/inst/examples/hf205.xml"

HF_address <- new("address",
                  deliveryPoint = "324 North Main Street",
                  city = "Petersham",
                  administrativeArea = "MA",
                  postalCode = "01366",
                  country = "USA")
publisher <- new("publisher",
                 organizationName = "Harvard Forest",
                 address = c(HF_address))

aaron <- as.person("Aaron Ellison <fakeaddress@email.com>")
contact <- as(aaron, "contact")
contact@address = HF_address
contact@organizationName = "Harvard Forest"
contact@phone = "000-000-0000"

keys <-
  c(new("keywordSet",
        keywordThesaurus = "LTER controlled vocabulary",
        keyword = c("bacteria",
                    "carnivorous plants",
                    "genetics",
                    "thresholds")),
    new("keywordSet",
        keywordThesaurus = "LTER core area",
        keyword =  c("populations", "inorganic nutrients", "disturbance")),
    new("keywordSet",
        keywordThesaurus = "HFR default",
        keyword = c("Harvard Forest", "HFR", "LTER", "USA")))



description <- "The Geographic region of the kelp bed data extends along the California coast, down through the coast of Baja, Mexico: Central California (Halfmoon Bay to Purisima Point), Southern California (Point Arguello to the United States/Mexico border including the Channel Islands) and Baja California (points south of the United States/Mexico border including several offshore islands)"
box <- c(-122.44, -117.15, 37.38, 30.00)

eml2:::set_geographicCoverage(box, description)
