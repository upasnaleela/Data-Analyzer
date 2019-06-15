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

list1<-list()
merged.list<-list()
x1<-list()
n=0
for(k in 1:length(jj))
{
n<-n+1
for(g in 1:length(jj[k]))
{
x1[k][g]<-match(jj[k][g],opinion.lexicon.pos)
x1[k][g]
x1[is.na(x1[k][g])] <- 0
}
}
x1



for(k in jj)
{
for(g in jj[k])
{
  if(x1[k][g] != 0)
	{	
	   list1[k][g] <- list(opinion.lexicon.pos[g],' ')
         print(opinion.lexicon.pos[g])
	   merged.list <- c(merged.list,list1)

	}

pos_list<-merged.list
lapply(pos_list, cat, file='analysis_pos.txt', append=TRUE) 
class(unlist(pos_list))

}
}



for(f in jj)
{

x1[f]<-match(jj[[f]],opinion.lexicon.pos)
x1[f]
x1[is.na(x1[f])] <- 0
x1[f]
list1[f] <- list()
merged.list[f]<-list()

for(i in x1[f]) {

  if(i > 0)
	{	
	   list1[f] <- list(opinion.lexicon.pos[i],' ')
         print(opinion.lexicon.pos[i])
	   merged.list[f] <- c(merged.list[k],list1[k])

	}
}
pos_list[f]<-merged.list[f]
lapply(pos_list[f], cat, file='analysis_pos.txt', append=TRUE) 
class(unlist(pos_list[f]))

}











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
