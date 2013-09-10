library(tm)
library(Rwordseg)
## song is a list
corpus <- function(song){
  
  # 删除英语
  removeEnglish <- function(x){
    gsub("[a-z]+|[A-Z]+","",x)
  }
  song <- lapply(song, removeEnglish)
  
  ##分词
  word <- lapply(song,segmentCN)
  
  ##形成语料库
  return (Corpus(VectorSource(word)))
  
 
}