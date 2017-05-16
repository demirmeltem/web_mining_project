library(shiny)
seasons <- c("2012-2013", "2012-2013", "2014-2015", "2015-2016", "2016-2017")
season_series <- all_series[all_series$Season == head(seasons, 1), ]$Show
get_season <- function(full_season) {
  season <- gsub("(20\\d{2})\\-20(\\d{2})", "\\1_\\2", full_season)
}

getTermMatrix <- function(series_name) {
  one_series_tweets <- getSeriesTweets(series_name)
  myCorpus = Corpus(VectorSource(one_series_tweets))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
                    c(stopwords("SMART"), "thy", "thou", "thee", "the", "and", "but"))
  
  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))
  
  m = as.matrix(myDTM)
  
  sort(rowSums(m), decreasing = TRUE)
}
