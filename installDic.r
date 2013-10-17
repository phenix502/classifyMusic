# 给Rwordseg加入词典
installDict("dicpos.txt", dictname="pos")
installDict("dicneg.txt", dictname="neg")
installDict("singerName.txt", dictname="singer")

# 加载情感词典
word.pos <- readLines("dicpos.txt", encoding="utf-8")
word.neg <- readLines("dicneg.txt", encoding="utf-8")

#分词
song.sweet <- lapply(song.sweet, segmentCN)
song.sad <- lapply(song.sad, segmentCN)

#根据情感词典挑选出具有感情色彩的词

song.sad.corpus.emotion <- Corpus(VectorSource(
  emotionWord(song.sweet, word.neg, word.pos)))

song.sweet.corpus.emotion <- Corpus(VectorSource(
emotionWord(song.sad, word.neg, word.pos)))

#合并语料库
song.corpus.emotion <- c(song.sad.corpus.emotion, song.sweet.corpus.emotion)
