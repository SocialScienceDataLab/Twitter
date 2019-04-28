# Open Libraries
  library(tidytext)
  library(dplyr)

# Set Working Directory
  setwd("/PATH")

# Load Dataset
  load("DATASET.Rda")

# Data Cleaning
  # Delete Links in the Tweets
  trumpsowntweets$text <- gsub("http.*", "", trumpsowntweets$text)
  trumpsowntweets$text <- gsub("https.*", "", trumpsowntweets$text)
  trumpsowntweets$text <- gsub("&amp;", "&", trumpsowntweets$text)
  # Remove punctuation, convert to lowercase, seperate all words
  trump_clean <- trumpsowntweets %>%
  dplyr::select(text) %>%
  unnest_tokens(word, text)
  # Load list of stop words - from the tidytext package
  data("stop_words")
  # View first 6 stop words
  head(stop_words)
  # No. of words
  nrow(trump_clean)
  # Remove stop words from your list of words
  cleaned_tweet_words <- trump_clean %>%
    anti_join(stop_words)
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
  
