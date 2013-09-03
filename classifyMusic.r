#加载包

library(topicmodels)
library(Rwordseg)

# 防止读入的所有string都被当成factor
options(stringsAsFactors=FALSE)
# 读入csv文件
Infor.sweet <- read.csv('sweetsong.csv', header=TRUE)
Infor.sad <- read.csv('sadsong.csv', header=TRUE)

# 取歌词lyric进行分析
song.sweet <- Infor.sweet$lyric
song.sad <- Infor.sad$lyric

# 形成DocTermMatrix
song.sweet.dtm <- dtm(song.sweet)$DocTermMatrix
song.sad.dtm <- dtm(song.sad)$DocTermMatrix

# 画词云

song.sweet.wordcloud <- wordCloud(song.sweet.dtm)
song.sad.wordcloud <- wordCloud(song.sad.dtm)



