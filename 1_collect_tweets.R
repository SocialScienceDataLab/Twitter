# Install Packages
  #install.packages("rtweet")
  #install.packages("ggmap")
  #install.packages("igraph")
  #install.packages("ggraph")
  #install.packages("tidytext")
  #install.packages("ggplot2")
  #install.packages("dplyr")
  #install.packages("readr")

# Set Working Directory
  setwd("/PATH")

# Open Libraries
  library(rtweet)
  library(ggmap)

# Speficy Authentification Token's provided in your Twitter App
  create_token(
    app = "APPNAME",
    consumer_key = "consumer_key",
    consumer_secret = "consumer_secret",
    access_token = "access_token",
    access_secret = "access_secret"
  )
  
# Collect a 'random' sample of Tweets for 10 seconds
  stream_tweets(
    q = "",
    timeout = 10,
    file_name = "sample.json",
    parse = FALSE
  )

  sample <- parse_stream("sample.json")
  
# Collect Tweets that contain specific keywords for 30 seconds
  stream_tweets(
    q = "trump,donald",
    timeout = 30,
    file_name = "trump.json",
    parse = FALSE
  )
  
  trump <- parse_stream("trump.json")
  save(trump,file="trump_live.Rda")

# Collect Tweets from a specific location
  # https://boundingbox.klokantech.com/
  
  stream_tweets(
    c(13.0883,52.3383,13.7612,52.6755), 
    timeout = 60,
    file_name = "berlin.json",
    parse = FALSE
  )
  
  berlin <- parse_stream("berlin.json")
  save(berlin,file="berlin_live.Rda")
  