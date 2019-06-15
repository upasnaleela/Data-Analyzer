

library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library(stringr)
poswords<-scan('positive-words.txt',what='character',comment.char=';')
negwords<-scan('negative-words.txt',what='character',comment.char=';')
trump.tweets=searchTwitter("trump",n=150)

df<-do.call("rbind",lapply(trump.tweets,as.data.frame))
df$text<-sapply(df$text,function(row) iconv(row,"latin1","ASCII",sub=""))#emoticons
df$text=gsub("(f|ht)tp(s?)://(.*)[.][a-z]+","",df$text)#http/ftp
textbag<-df$text

score.sentiment=function(sentences,poswords,negwords,.progress='none')
{
	require(plyr)
	require(stringr)
	list=lapply(sentences,function(sentence,poswords,negwords)
	{
		sentence=gsub('[[:punct:]]',' ',sentence)
		sentence=gsub('[[:cntrl:]]',' ',sentence)
		sentence=gsub('\\d+','',sentence)#remove decimal number
		sentence=gsub('\n','',sentence)#remove new line
		
		sentence=tolower(sentence)
		word.list=str_split(sentence,'\\s+')
		words=unlist(word.list)#change a list to character vector
		pos.matches=match(words,poswords)
		neg.matches=match(words,negwords)
		pos.matches=!is.na(pos.matches)
		neg.matches=!is.na(neg.matches)
		pp=sum(pos.matches)
		nn=sum(neg.matches)
		score=sum(pos.matches)-sum(neg.matches)
		list1=c(score,pp,nn)
		return(list1)
	},poswords,negwords)
	score_new=lapply(list,'[[',1)
	pp1=lapply(list,'[[',2)
	nn1=lapply(list,'[[',3)
	scores.df=data.frame(score=score_new,text=sentences)
	positive.df=data.frame(positive=pp1,text=sentences)
	negative.df=data.frame(negative=nn1,text=sentences)
	list_df=list(scores.df,positive.df,negative.df)
	return(list_df)
}



result=score.sentiment(textbag,poswords,negwords)
library(reshape)
#create a copy of result data frame.
test1=result[[1]]
test2=result[[2]]
test3=result[[3]]

test1$text=NULL
test2$text=NULL
test3$text=NULL

q1=test1[1,]
q2=test2[1,]
q3=test3[1,]

qq1=melt(q1, ,var='score')
qq2=melt(q2, ,var='positive')
qq3=melt(q3, ,var='negative')

qq1['score']=NULL
qq2['positive']=NULL
qq3['negative']=NULL
table1=data.frame(Text=result[[1]]$text,score=qq1)
table2=data.frame(Text=result[[2]]$text,score=qq2)
table3=data.frame(Text=result[[3]]$text,score=qq3)

#merge the table
table_final = data.frame(Text = table1$Text, score = table1$value, positive=table2$value,negative = table3$value)







#positive_percentage
#renaming
posSc=table_final$positive
negSc=table_final$negative

#adding column
table_final$PosPercentage=posSc/(posSc+negSc)

#replacing NAN with 0

pp=table_final$PosPercentage
pp[is.nan(pp)]<-0
table_final$PosPercentage=pp

#negative percentage

#adding column
table_final$NegPercentage=negSc/(negSc+posSc)

#replacing nan with 0
nn=table_final$NegPercentage
nn[is.nan(nn)]<-0
table_final$NegPercentage=nn
table_final

	
