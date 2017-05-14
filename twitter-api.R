api_key <- "LqNrJLIvRK7GhBKkVkkdMgBL8" # From dev.twitter.com
api_secret <- "PDWritHiyzN83YN2eVNll8IWHg8Sop1jQiT80WIIvJJ4Ry8tbp" # From dev.twitter.com
token <- "1375352240-VIXKWui1T2PvsQXtAtMUBKWBpksilDUIxo2FD7x" # From dev.twitter.com
token_secret <- "b2tPn1dFVshnV5zCb7h4jSYWXlm5BeAlfdNnA1cYvEIGl" # From dev.twitter.com

# Create Twitter Connection
setup_twitter_oauth(api_key, api_secret, token, token_secret)


tweets <- searchTwitter("arrow OR #arrow", n=100, lang="en", since="2014-08-20")
tweets.df <- twListToDF(tweets)
