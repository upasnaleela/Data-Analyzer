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
jj<-str_split(corpus2,pattern="\\s+")
lapply(jj,function(x){sum(!is.na(match(x,opinion.lexicon.pos)))})
lapply(jj,function(x){sum(!is.na(match(x,opinion.lexicon.neg)))})
score<-unlist(lapply(jj,function(x){sum(!is.na(match(x,opinion.lexicon.pos)))-sum(!is.na(match(x,opinion.lexicon.neg)))}))
score


