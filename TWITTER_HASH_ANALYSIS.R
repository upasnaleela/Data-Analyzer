tw=userTimeline("BarackObama",n=3200)
tw=twListToDF(tw)
vecl=tw$text

#extract the hash tags
hash.pattern="#[[:alpha:]]+"

have.hash=grep(x=vecl,pattern=hash.pattern)#store indexes of tweets which have hashes
hash.matches=gregexpr(pattern=hash.pattern,
				text=vecl[have.hash])
extracted.hash=regmatches(x=vecl[have.hash],m=hash.matches)#the acual hash tags are stored here
df=data.frame(table(tolower(unlist(extracted.hash))))#data formed with var1(hashtag),freq of hashtag
colnames(df)=c("tag","freq")
df=df[order(df$freq,decreasing=TRUE),]


dat=head(df,50)
dat2=transform(dat,tag=reorder(tag,freq))#reorder so that highest freq is at the top
library(ggplot2)
p=ggplot(dat2,aes(x=tag,y=freq)) + geom_bar(stat="identity",fill="blue")
p+coord_flip()+labs(title="Hashtag frequencies in the tweets of the obama team(@barakObama)")
