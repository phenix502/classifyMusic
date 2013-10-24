#加载包
library(tm)
library(Rwordseg)
library(RTextTools)
library(FSelector)


# 防止读入的所有string都被当成factor
options(stringsAsFactors=FALSE)
# 读入csv文件
Infor.sweet <- read.csv('sweetsong.csv', header=TRUE)
Infor.sad <- read.csv('sadsong.csv', header=TRUE)

# 取歌词lyric进行分析
song.sweet <- Infor.sweet$lyric
song.sad <- Infor.sad$lyric


# 形成DocumentTermMatrix
corpus.dtm <- dtm(corpus)
corpus.dtm.tfidf <- dtm(corpus, tfidf=TRUE)
# 情感词典
corpus.emotion.dtm <- dtm(corpus.emotion)


# 转为data frame
corpus.df <- as.data.frame(inspect(corpus.dtm))
label <- c(rep("sad",764), rep("sweet",861))
label <- factor(label)
# 标注标签
corpus.df$label <- label
# 卡方检验
weights.chi <- chi.squared(label~., corpus.df)
subset.chi <- cutoff.k(weights.chi, 200)
f.chi <- as.simple.formula(subset.chi, "label")

# information gain

weights.in <- information.gain(label~., corpus.df)
subset.in <- cutoff.k(weights.in, 200)
f.in <- as.simple.formula(subset.in, "label")

weights.rf <- random.forest.importance(label~., corpus.df)
#rownames(song.corpus.dataframe) <- 1:nrow(song.corpus.dataframe)
#song.corpus.dataframe.tfidf <- as.data.frame(inspect(song.corpus.dtm.tfidf))
#rownames(song.corpus.dataframe.tfidf) <- 1:nrow(song.corpus.dataframe.tfidf)


# 提取出来的特征做为一个新的数据框

feature.chi <- names(corpus.df) %in% subset.chi
df.chi <- corpus.df[feature.chi] 

model3 <- ksvm(label~.,data=df.chi,kernel='rbfdot')
plot(model3,data=df.chi)

## 数据分析阶段










# 形成DocTermMatrix
song.sweet.dtm <- dtm(song.sweet)$DocTermMatrix
song.sad.dtm <- dtm(song.sad)$DocTermMatrix

# 画词云

song.sweet.wordcloud <- wordCloud(song.sweet.dtm)
song.sad.wordcloud <- wordCloud(song.sad.dtm)



