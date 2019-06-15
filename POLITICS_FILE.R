getwd()
#file<-file.choose(new = FALSE)
readLines("political blog.txt")
str(readLines(file))
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
poltics_words<-scan('POLITICS.txt',what='character',comment.char=';')
 score<-sum(!is.na(match(textbag,poltics_words)))
 score
wordcloud(textbag,min.freq=1,random.order=FALSE,scale=c(3,0.5),color=rainbow(4),max.words=50)


corpus3<-Corpus(VectorSource(text2))
corpus3
x11
tdm1<-TermDocumentMatrix(corpus3)
tdm1
m<-as.matrix(tdm1)
m
jj<-str_split(text2,pattern="\\s+")
jj

x1<-match(jj[[1]],poltics_words)
x1
class(x1)
x1[is.na(x1)] <- 0
x1
list1 <- list()
merged.list<-list()

for(i in x1) {

  if(i > 0)
	{	
	   list1 <- list(poltics_words[i],' ')
         print(poltics_words[i])
	   merged.list <- c(merged.list,list1)

	}
}
poltics_words_list<-merged.list
lapply(poltics_words_list, cat, file='analysis_politics.txt', append=TRUE) 
class(unlist(poltics_words_list))



wordcloud(unlist(poltics_words_list),min.freq=1)
if(score>2)
{
print("This file contains POLITICS related information")
}
 
 
 
