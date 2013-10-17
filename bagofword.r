removeEnglish <- function(x){
  gsub("[a-z]+|[A-Z]+","",x)
}

# 伤感歌曲分词   组成语料库
word.sad <- lapply(Infor.sad$lyric,removeEnglish)
word.sad <- lapply(word.sad,segmentCN)
corpus.sad <- Corpus(VectorSource(word.sad))

# 甜蜜歌曲分词   组成语料库
word.sweet <- lapply(Infor.sweet$lyric, removeEnglish)
word.sweet <- lapply(word.sweet, segmentCN)
corpus.sweet <- Corpus(VectorSource(word.sweet))

# 合成预料库
corpus <- c(corpus.sad, corpus.sweet)