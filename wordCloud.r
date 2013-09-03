#词云分析
library(wordcloud)
wordCloud <- function(DocTermMatrix){
  m <- as.matrix(t(DocTermMatrix))
  wordFreq <- sort(rowSums(m), decreasing=TRUE)
  wordcloud(words = names(wordFreq),freq = wordFreq,
          random.order = F, colors = brewer.pal(8, "Dark2"))
}