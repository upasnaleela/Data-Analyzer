library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library(stringr)
poswords<-scan('positive-words.txt',what='character',comment.char=';')
negwords<-scan('negative-words.txt',what='character',comment.char=';')
trump.tweets=searchTwitter("trump",n=10)

df<-do.call("rbind",lapply(trump.tweets,as.data.frame))
df$text<-sapply(df$text,function(row) iconv(row,"latin1","ASCII",sub=""))#emoticons
df$text=gsub("(f|ht)tp(s?)://(.*)[.][a-z]+","",df$text)#http/ftp
textbag<-df$text