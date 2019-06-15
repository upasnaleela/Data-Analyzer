token <- 'EAACEdEose0cBAFKCzZArlDQgCVrbsZCwZCVzOUcIJUiyKUU4TdIyLLaZCvcFpIM75ed4EtqZB06rBpzDwAkX63UXP36cHG8E2MInyzZCj60mZBQZC0KLNkLdR78UpqxpTaGuKcJdRyFWNv2Ck1lJqjE5xqyjAp7gT5BYD1nnfDBrFCrcExU3Q4GalUYWFhv0lClas3XP2OHfBQZDZD'
me <- getUsers("me", token, private_info=TRUE)

getPage("nike",token,n=10)#most recent posts by page nike


getPage("nike",token,n=10)$message

#get post from page
#getting information and likes/comments about most recent posts
nike_page<-getPage(page="nike",token)
nike_post<-getPost(post=nike_page$id[1],n=10,token)
text<-(nike_post$comments)$message

text2<-gsub(pattern="\\W",replace=" ",text)
text2
text2<-gsub(pattern="\\d",replace=" ",text2)
text2<-tolower(text2)
library(tm)
text2<-removeWords(text2,stopwords())
text2<-gsub(pattern="\\b[A-z]\\b{1}",replace=" ",text2)
text2<-stripWhitespace(text2)
library(stringr)
library(wordcloud)
textbag<-str_split(text2,pattern="\\s+")
textbag<-unlist(textbag)
 poswords<-scan('positive-words.txt',what='character',comment.char=';')
 negwords<-scan('negative-words.txt',what='character',comment.char=';')
 score<-sum(!is.na(match(textbag,poswords)))-sum(!is.na(match(textbag,negwords)))
 score
 wordcloud(textbag,min.freq=1,random.order=FALSE,scale=c(3,0.5),color=rainbow(2))
 













