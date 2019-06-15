library(twitteR)
library(ROAuth)

consumer_key<-"sI8ufoxHnhdb28ouN0IhC5HW1"
consumer_secret<-"HlVd8YYSexUDJs9hWtZc8KujMZN2DlT4HO2hMYPIUDLnQFvCVY"

accesstoken<-"3367472419-cuMifl7YfG43DW5x9YCNtTMLz7p90for2ZO6h3A"
accesssecret<-"SpC5G34eGYRMF5wyDMx1uM630R4zfSM0dGPod0C19XsuZ"

download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")

setup_twitter_oauth(consumer_key,consumer_secret,accesstoken,accesssecret)

cred <- OAuthFactory$new(consumerKey=consumer_key,
				consumerSecret=consumer_secret,
				requestURL='https://api.twitter.com/oauth/request_token',
				accessURL='https://api.twitter.com/oauth/access_token',
				authURL='https://api.twitter.com/oauth/authorize')

cred$handshake(cainfo="cacert.pem")




