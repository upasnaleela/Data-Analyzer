library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library(stringr)
trump.tweets=searchTwitter("trump",n=150)

df<-do.call("rbind",lapply(trump.tweets,as.data.frame))
df$text<-sapply(df$text,function(row) iconv(row,"latin1","ASCII",sub=""))#emoticons
df$text=gsub("(f|ht)tp(s?)://(.*)[.][a-z]+","",df$text)#http/ftp
textbag<-df$text
t<-textbag
textbag<-removeWords(textbag,stopwords())
textbag<-stripWhitespace(textbag)
textbag<-trimws(textbag)
poswords<-scan('positive-words.txt',what='character',comment.char=';')
negwords<-scan('negative-words.txt',what='character',comment.char=';')
textbag<-trimws(textbag)
textbag
for(i in 1:length(textbag))
{
	countneg<-0
	countpos<-0
	print(t[i])
	lines<-str_split(textbag[i],pattern="\\s+")
	lines<-unlist(lines)
	for(j in 1:length(lines))
	{
		
	neg<-!is.na(match(lines[[j]],negwords))
	pos<-!is.na(match(lines[[j]],poswords))
	if(neg==TRUE)
		countneg<-countneg+1
	if(pos==TRUE)
		countpos<-countpos+1

	}
	score<-countneg-countpos
	m<-countneg%%2 
	if(score==0)
	{
		print("Neutral Statement")
	}
	else if(m==1)
	{
		print("Negative statement")
	}
	else
	{
		print("Postive statemrnt")

	}
}




