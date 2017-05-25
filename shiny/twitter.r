#install.packages("twitteR")
#install.packages("RCurl")
#install.packages("RJSONIO")
#install.packages("stringr")
library(twitteR)
library(RCurl)
library(RJSONIO)
library(stringr)

api_key <- "AsZZrtfBJh4UuUoyyyoXxCFkT"
api_secret <- "QEeM4rzjm1Swn5dQiOtnfVWaKyZ2MBjPSEqyvL7dNCHbbmB6Cp"
token <- "234059187-XUVObWftjdrvuKdX3wfHhiTHSsEqDl0DWSnYuYn8"
token_secret <- "hfr4ywoys9Hu5rcvB6p7E7JI4L4hG5lt41dSKJNawDFan"
setup_twitter_oauth(api_key, api_secret, token, token_secret)

getSeriesTweets <- function(name) {
  tweets <- twListToDF(
    searchTwitter(
      paste("#", gsub(" ", "", name), sep = ""), 
      n=500, 
      lang="en"))
  tweets <- tweets$text
  tweets <- gsub("^RT", "", tweets)
  tweets <- gsub("@", "", tweets)
  tweets <- gsub("#", "", tweets)
  tweets <- iconv(gsub("\\n", " ", tweets), to="ASCII", sub="")
  tweets
}

