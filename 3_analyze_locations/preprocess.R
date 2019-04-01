# Set Working Directory
  setwd("/PATH")

# Load Data
  load("DATASET.Rda")

# Seperate Geo-Information (Lat/Long) Into Two Variables
  manhattan <- tidyr::separate(data=manhattan,
                      col=geo_coords,
                      into=c("Latitude", "Longitude"),
                      sep=",",
                      remove=FALSE)

# Remove Parentheses
  manhattan$Latitude <- stringr::str_replace_all(manhattan$Latitude, "[c(]", "")
  manhattan$Longitude <- stringr::str_replace_all(manhattan$Longitude, "[)]", "")

# Store as numeric
  manhattan$Latitude <- as.numeric(manhattan$Latitude)
  manhattan$Longitude <- as.numeric(manhattan$Longitude)

# Delete Posts outside of Speficied Bounding Box:
  manhattan<-manhattan[(manhattan$Latitude >= 40.698136 & manhattan$Latitude <= 40.798978),]
  manhattan<-manhattan[(manhattan$Longitude >= -74.022208 & manhattan$Longitude <= -73.936377),]

# Save Data
  save(manhattan,file="manhattan_geo.Rda")
