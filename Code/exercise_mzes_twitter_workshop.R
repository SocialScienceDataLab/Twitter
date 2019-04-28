# Install Packages
  install.packages("rtweet")
  install.packages("tidytext")
  install.packages("ggplot2")
  install.packages("dplyr")
  install.packages("readr")

# Set Working Directory
  setwd("/PATH")

# Open Libraries
  library(rtweet)
  library(tidytext)
  library(ggplot2)
  library(dplyr)
  library(readr)

# Speficy Token's provided in Twitter App (for test purposes only!)
  create_token(
    app = "mzes_twitter_workshop",
    consumer_key = "PXLnj0cAVzmgqQAh61UsAdhP6",
    consumer_secret = "l7cDxpOv0z4I4zck66zyGw8FtISqsjGjtEe5c891p0uRWRTvp4",
    access_token = "778592420686655488-GTYrWkKFiMeSsSQbi9SHxOw6eR4jgul",
    access_secret = "Ld6mPM9B47BQQmJCHQvyX00Npq0GgXK0Kca4x3nlliVKF"
  )

######################
# COLLECT THE TWEETS #
######################
  
# Collect Tweets that contain specific keyword in realtime
  stream_tweets(
    q = "KEYWORD(S)",
    timeout = 60,
    file_name = "mytweets.json",
    parse = FALSE
  )
  
  mytweets <- parse_stream("mytweets.json")
  
#######################
# ANALYZE THE CONTENT #
#######################
  
# Data Cleansing
  # Delete Links in the Tweets
  mytweets$text <- gsub("http.*", "", mytweets$text)
  mytweets$text <- gsub("https.*", "", mytweets$text)
  mytweets$text <- gsub("&amp;", "&", mytweets$text)
  # Remove punctuation, convert to lowercase, seperate the words
  mytweets_clean <- mytweets %>%
    dplyr::select(text) %>%
    unnest_tokens(word, text)
  # Load Stopword lists
  german <- get_stopwords("de")
  english <- get_stopwords("en")
  # No. of words
  nrow(mytweets_clean)
  # Remove stop words from your list of words
  cleaned_tweet_words <- mytweets_clean %>%
    anti_join(english)
  cleaned_tweet_words <- cleaned_tweet_words %>%
    anti_join(german)
  # There should be fewer words now
  nrow(cleaned_tweet_words)
  
  # Plot the top 15 words
  cleaned_tweet_words %>%
    count(word, sort = TRUE) %>%
    top_n(15) %>%
    mutate(word = reorder(word, n)) %>%
    ggplot(aes(x = word, y = n)) +
    geom_col() +
    xlab(NULL) +
    coord_flip() +
    labs(y = "Count",
         x = "Unique words",
         title = "Count of unique words found in tweets",
         subtitle = "Stop words removed from the list")
