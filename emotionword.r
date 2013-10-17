
# 输入分词好的一首歌和情感词典，输出带有情感色彩的词的下标
# 如index<- emotionWord(word[[1]],word.pos)
emotionWord <- function(word,dic.neg,dic.pos){
  alist <- list()
  for(i in 1:length(word)){
    index.neg <- word[[i]] %in% dic.neg
    index.pos <- word[[i]] %in% dic.pos
    index <- index.neg|index.pos
    if (i==1)  alist <- list(word[[i]][index])
    else alist <- append(alist,list(word[[i]][index]))
  }
  
  return (alist)
}


