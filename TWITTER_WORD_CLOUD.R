trump_text=sapply(trump.tweets,function(x) x$getText())#Sapply return a vector
df<-do.call("rbind",lapply(trump.tweets,as.data.frame))#lapply returns a list
trump_text<-sapply(df$text,function(row) iconv(row,"latin1","ASCII",sub=""))
str(trump_text)#gives the summary /internal structure of object

library(tm)#tm text mining
trump_corpus<-Corpus(VectorSource(trump_text))#corpus is collectio of text documents
trump_corpus
inspect(trump_corpus[1])

#clean text
library(wordcloud)
trump_clean<-tm_map(trump_corpus,removePunctuation)
trump_clean<-tm_map(trump_clean,content_transformation)
trump_clean<-tm_map(trump_clean,content_transformer(tolower))
trump_clean<-tm_map(trump_clean,removeWords,stopwords("english"))
trump_clean<-tm_map(trump_clean,removeNumbers)
trump_clean<-tm_map(trump_clean,stripWhitespace)
wordcloud(trump_clean,random.order=F,max.words=80,col=rainbow(50),scale=c(3.5,1))
