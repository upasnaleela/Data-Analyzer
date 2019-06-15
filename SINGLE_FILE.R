getwd()
file<-file.choose(new = FALSE)
readLines(file)
str(readLines(file)
paste(readLines(file),collapse=" ")
text<-paste(readLines(file),collapse=" ")
text
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
 
corpus3<-Corpus(VectorSource(text2))
corpus3
x11
tdm1<-TermDocumentMatrix(corpus3)
tdm1
m<-as.matrix(tdm1)
m
jj<-str_split(text2,pattern="\\s+")
jj

x1<-match(jj[[1]],poswords)
x1
class(x1)
x1[is.na(x1)] <- 0
x1
list1 <- list()
merged.list<-list()

for(i in x1) {

  if(i > 0)
	{	
	   list1 <- list(poswords[i],' ')
         print(poswords[i])
	   merged.list <- c(merged.list,list1)

	}
}
pos_list<-merged.list
lapply(pos_list, cat, file='analysis_pos.txt', append=TRUE) 
class(unlist(pos_list))








x2<-match(jj[[1]],negwords)
x2
class(x2)
x2[is.na(x2)] <- 0
x2
list2 <- list()
merged.list2<-list()

for(i in x2) {

  if(i > 0)
	{	
	   list2 <- list(negwords[i],' ')
         print(negwords[i])
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
text2<-lapply(a1,FUN=paste,collapse=" ")

text2<-gsub(pattern="\\W",replace=" ",text2)
text2<-gsub(pattern="\\d",replace=" ",text2)
text2<-tolower(text2)
text2<-removeWords(text2,stopwords("english"))
text2<-gsub(pattern="\\b[A_z]\\b{1}",replace=" ",text2)
text2<-stripWhitespace(text2)

library(tm)
library(stringr)
library(wordcloud)
wordcloud(text2,random.order=FALSE,col=rainbow(3))
comparison.cloud(text2,max.words=30)
corpusss<-Corpus(VectorSource(text2))

x11
tdm1<-TermDocumentMatrix(corpusss)
tdm1
m1<-as.matrix(tdm1)
colnames(m1)<-c("Positive","Negative")
comparison.cloud(m1)
one<-comparison.cloud(m1)




score<-unlist(lapply(jj,function(x){sum(!is.na(match(x,poswords)))-sum(!is.na(match(x,negwords)))}))
score



png("my.png", width=12, height=8, units="in", res=300)
comparison.cloud(m1)
dev.off()
