getwd()
file<-file.choose(new = FALSE)
text<-paste(readLines(file),collapse="`")
text
textbag<-str_split(text,pattern="\\`")
textbag<-unlist(textbag)
textbag
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




