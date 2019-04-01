server <- function(input,output, session){
  
  data <- reactive({
    x <- manhattan
  })
  
  output$mymap <- renderLeaflet({
    df <- data()
    
    m <- leaflet(data = df) %>%
      addTiles() %>%
      addMarkers(
                 clusterOptions = markerClusterOptions(),
                 lng = ~Longitude,
                 lat = ~Latitude,
                 popup = paste("Location:", manhattan$place_full_name, "<br>",
                               "Time Stamp:", manhattan$created_at, "<br>",
                               "Tweet:", manhattan$text))
    m
  })
}