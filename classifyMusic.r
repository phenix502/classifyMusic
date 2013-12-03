#加载包
# Fselector，用随机森林算法选择最重要的前几个变量
# 此文档为重要分析文档，会调用别的函数
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


# 形成DocumentTermMatrix， 调入dtm.r 文件
corpus.dtm <- dtm(corpus)
corpus.dtm.tfidf <- dtm(corpus, tfidf=TRUE)

# 加载情感词典
corpus.emotion.dtm <- dtm(corpus.emotion)


# 转为data frame
corpus.df <- as.data.frame(inspect(corpus.dtm))
# 标注标签
label <- c(rep("sad",764), rep("sweet",861))
label <- factor(label)
corpus.df$label <- label


# 卡方检验
weights.chi <- chi.squared(label~., corpus.df)
subset.chi <- cutoff.k(weights.chi, 200)
f.chi <- as.simple.formula(subset.chi, "label")

# information gain
weights.in <- information.gain(label~., corpus.df)
subset.in <- cutoff.k(weights.in, 200)
f.in <- as.simple.formula(subset.in, "label")


## 随机森林算法选取前100个重要的词语
weights.rf <- random.forest.importance(label~., corpus.df, 1)
subset <- cutoff.k(weights.rf, 100)
f <- as.simple.formula(subset, "class")


# 提取出来的特征做为一个新的数据框
d <- data.frame(word = rownames(weights.rf), freq= weights.rf$attr_importance)
# 按重要性从大到小排列
newdata <- d[order(-d$freq),]
#画出词云
wordcloud(d$word, d$freq, random.order = F, colors = brewer.pal(8, "Dark2"))


