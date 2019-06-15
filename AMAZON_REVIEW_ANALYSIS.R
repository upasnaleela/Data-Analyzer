install.packages('curl')
install.packages('tm')
install.packages('RTextTools')
install.packages('plyr')
install.packages('stringr')
install.packages('dplyr')
install.packages('tidytext')
install.packages('tm')
install.packages('stringr')
install.packages('wordcloud')


library(curl)
library(tm)
library(RTextTools)
library(plyr)
library(stringr)
library(dplyr)
library(tidytext)
library(tm)
library(stringr)
library(wordcloud)



#Read the URL
url <- "https://www.amazon.com/Girl-Train-Novel-Paula-Hawkins/product-reviews/0735219753/ref=cm_cr_dp_d_acr_sr?ie=UTF8&reviewerType=avp_only_reviews"
data <- read_html(paste(url,1,sep = ""))
review <- data %>% html_nodes(".review-text") %>%  html_text()

for(level in c(2:500)){
  data <- read_html(paste(url,level,sep = ""))
  review <- c(review,data %>% html_nodes(".review-text") %>% html_text())
}

review <- as.data.frame(review)
View(review)
write.csv(review, "Amazon_Comments.csv")



review <- read.csv("C:\\Users\\gadhavi\\Documents\\Amazon_Comments.csv")




opinion.lexicon.pos<-scan("positive-words.txt",what='character',comment.char=';'
)
opinion.lexicon.neg<-scan("negative-words.txt",what='character',comment.char=';'
)
review<-review$review
corpus2<-gsub(pattern="\\W",replace=" ",review)
corpus2<-gsub(pattern="\\d",replace=" ",corpus2)
corpus2
corpus2<-tolower(corpus2)
corpus2
corpus2<-removeWords(corpus2,stopwords("english"))
corpus2
corpus2<-gsub(pattern="\\b[A_z]\\b{1}",replace=" ",corpus2)
corpus2<-stripWhitespace(corpus2)
corpus2


wordcloud(corpus2,random.order=FALSE,col=rainbow(3),max.words=25,min.freq=3)

corpus3<-Corpus(VectorSource(corpus2))
corpus3
x11
tdm<-TermDocumentMatrix(corpus3)
tdm
m<-as.matrix(tdm)
m

jj<-str_split(corpus2,pattern="\\s+")
jj
match(jj[[1]],opinion.lexicon.pos)
x1<-match(jj[[2]],opinion.lexicon.pos)
x1
class(x1)
x1[is.na(x1)] <- 0
x1
list1 <- list()
merged.list<-list()

for(i in x1) {

  if(i > 0)
	{	
	   list1 <- list(opinion.lexicon.pos[i],' ')
         print(opinion.lexicon.pos[i])
	   merged.list <- c(merged.list,list1)

	}
}
pos_list<-merged.list
lapply(pos_list, cat, file='analysis_pos.txt', append=TRUE) 
class(unlist(pos_list))







match(jj[[1]],opinion.lexicon.neg)
x2<-match(jj[[2]],opinion.lexicon.neg)
x2
class(x2)
x2[is.na(x2)] <- 0
x2
list2 <- list()
merged.list2<-list()

for(i in x2) {

  if(i > 0)
	{	
	   list2 <- list(opinion.lexicon.neg[i],' ')
         print(opinion.lexicon.neg[i])
	   merged.list2 <- c(merged.list2,list2)

	}
}
neg_list<-merged.list2
lapply(neg_list, cat, file='analysis_neg.txt', append=TRUE) 
class(unlist(neg_list))








wordcloud(unlist(pos_list),min.freq=1)
wordcloud(unlist(neg_list),min.freq=1)


filelist1<-list("C:\\Users\\gadhavi\\Documents\\analysis_pos.txt","C:\\Users\\gadhavi\\Documents\\analysis_neg.txt")

a1<-lapply(filelist1,FUN=readLines)
corpuss<-lapply(a1,FUN=paste,collapse=" ")

corpuss<-gsub(pattern="\\W",replace=" ",corpuss)
corpuss<-gsub(pattern="\\d",replace=" ",corpuss)
corpuss<-tolower(corpuss)
corpuss<-removeWords(corpuss,stopwords("english"))
corpuss<-gsub(pattern="\\b[A_z]\\b{1}",replace=" ",corpuss)
corpuss<-stripWhitespace(corpuss)


wordcloud(corpuss,random.order=FALSE,col=rainbow(3))

corpusss<-Corpus(VectorSource(corpuss))

x11
tdm1<-TermDocumentMatrix(corpusss)
tdm1
m1<-as.matrix(tdm1)
colnames(m1)<-c("Positive","Negative")
comparison.cloud(m1)

