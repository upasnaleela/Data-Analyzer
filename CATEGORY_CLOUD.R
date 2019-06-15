getwd()
opinion.lexicon.pos<-scan("positive-words.txt",what='character',comment.char=';'
)
opinion.lexicon.neg<-scan("negative-words.txt",what='character',comment.char=';'
)
folder<-choose.dir(getwd(), "Choose a suitable folder")
list.files(path=folder)
filelist<-list.files(path=folder,pattern="*.txt")
filelist
filelist<-paste(folder,"\\",filelist,sep="")
filelist
a<-lapply(filelist,FUN=readLines)
corpus<-lapply(a,FUN=paste,collapse=" ")
corpus
corpus2<-gsub(pattern="\\W",replace=" ",corpus)
corpus2<-gsub(pattern="\\d",replace=" ",corpus2)
corpus2
corpus2<-tolower(corpus2)
corpus2
corpus2<-removeWords(corpus2,stopwords("english"))
corpus2
corpus2<-gsub(pattern="\\b[A_z]\\b{1}",replace=" ",corpus2)
corpus2<-stripWhitespace(corpus2)
corpus2

library(tm)
library(stringr)
library(wordcloud)
wordcloud(corpus2,random.order=FALSE,col=rainbow(3),max.words=25,min.freq=3)
comparison.cloud(corpus2,max.words=25)
corpus3<-Corpus(VectorSource(corpus2))
corpus3
x11
tdm<-TermDocumentMatrix(corpus3)
tdm
m<-as.matrix(tdm)
m
colnames(m)<-c(list.files(path=folder))
comparison.cloud(m,max.words=100)

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
comparison.cloud(corpuss,max.words=30)
corpusss<-Corpus(VectorSource(corpuss))

x11
tdm1<-TermDocumentMatrix(corpusss)
tdm1
m1<-as.matrix(tdm1)
colnames(m1)<-c("Positive","Negative")
comparison.cloud(m1)

score<-unlist(lapply(jj,function(x){sum(!is.na(match(x,opinion.lexicon.pos)))-sum(!is.na(match(x,opinion.lexicon.neg)))}))
score
