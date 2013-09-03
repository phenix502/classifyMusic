library(tm)

## song is a list
dtm <- function(song){
  
  # 删除英语
  removeEnglish <- function(x){
    gsub("[a-z]+|[A-Z]+","",x)
  }
  song <- lapply(song, removeEnglish)
  
  ##分词
  word <- lapply(song,segmentCN)
  
  ##形成语料库
  cor <- Corpus(VectorSource(word))
  
  ## 文档-词矩阵 词的长度大于1就纳入矩阵  TFIDF
  mystopwords <- readLines("stopwords.txt")
  cor.dtm <- DocumentTermMatrix(cor, control=list( wordLengths = c(1, Inf),stopwords=mystopwords,weighting = weightTfIdf))
  
  ##去掉稀疏矩阵中低频率的词
  cor.dtm <- removeSparseTerms(cor.dtm, 0.99)
  
  ## 使得每一行至少有一个词不为0
  rowTotals <- apply(cor.dtm, 1, sum)
  cor.dtm <- cor.dtm[rowTotals > 0]
  return (list(corpus=cor, DocTermMatrix=cor.dtm))
}