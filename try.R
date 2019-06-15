
rquery.wordcloud <- function(x, type=c("text", "url", "file"), 
                             lang="english", excludeWords=NULL, 
                             textStemming=FALSE,  colorPalette="Dark2",
                             min.freq=3, max.words=200)
{ 
  library("tm")
  library("SnowballC")
  library("wordcloud")
  library("RColorBrewer") 
  
  if(type[1]=="file") text <- readLines(x)
  else if(type[1]=="url") text <- html_to_text(x)
  else if(type[1]=="text") text <- x
  
  
  docs <- Corpus(VectorSource(text))
  
  docs <- tm_map(docs, content_transformer(tolower))
  
  docs <- tm_map(docs, removeNumbers)
  
  docs <- tm_map(docs, removeWords, stopwords(lang))
  
  docs <- tm_map(docs, removePunctuation)
  
  docs <- tm_map(docs, stripWhitespace)
  
  if(!is.null(excludeWords)) 
    docs <- tm_map(docs, removeWords, excludeWords) 
  
  if(textStemming) docs <- tm_map(docs, stemDocument)
  
  tdm <- TermDocumentMatrix(docs)
  m <- as.matrix(tdm)
  v <- sort(rowSums(m),decreasing=TRUE)
  d <- data.frame(word = names(v),freq=v)
  # check the color palette name 
  if(!colorPalette %in% rownames(brewer.pal.info)) colors = colorPalette
  else colors = brewer.pal(8, colorPalette) 
  
  set.seed(1234)
  wordcloud(d$word,d$freq, min.freq=min.freq, max.words=max.words,
            random.order=FALSE, rot.per=0.35, 
            use.r.layout=FALSE, colors=colors)
  
  invisible(list(tdm=tdm, freqTable = d))
}

#++++++++++++++++++++++
# Helper function
#++++++++++++++++++++++
# Download and parse webpage
html_to_text<-function(url){
  library(RCurl)
  library(XML)
  # download html
  html.doc <- getURL(url)  
  #convert to plain text
  doc = htmlParse(html.doc, asText=TRUE)
  # "//text()" returns all text outside of HTML tags.
  # We also don't want text such as style and script codes
  text <- xpathSApply(doc, "//text()[not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)]", xmlValue)
  # Format text vector into one character string
  return(paste(text, collapse = " "))
}