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
## 数据分析阶段

# 1 表示sad 2表示sweet
class <- c(rep(1,764), rep(2, 861))
class <- as.factor(class)

# create a container
container <- create_container(song.corpus.emotion.dtm, class,trainSize=1:1528, testSize=1529:1625, virgin=FALSE)

# training models
SVM <- train_model(container, "SVM")
GLMNET <- train_model(container, "GLMNET")
MAXENT <- train_model(container, "MAXENT")
SLDA <- train_model(container, "SLDA")
BOOSTING <- train_model(container, "BOOSTING")
BAGGING <- train_model(container, "BAGGING")
RF <- train_model(container, "RF")
NNET <- train_model(container, "NNET")
TREE <- train_model(container, "TREE")

# classifying data using trained models
SVM_CLASSIFY <- classify_model(container, SVM)
GLMNET_CLASSIFY <- classify_model(container, GLMNET)
MAXENT_CLASSIFY <- classify_model(container, MAXENT)
SLDA_CLASSIFY <- classify_model(container, SLDA)
BOOSTING_CLASSIFY <- classify_model(container, BOOSTING)
BAGGING_CLASSIFY <- classify_model(container, BAGGING)
RF_CLASSIFY <- classify_model(container, RF)
NNET_CLASSIFY <- classify_model(container, NNET)
TREE_CLASSIFY <- classify_model(container, TREE)

CLASSIFY <- cbind(SVM_CLASSIFY, SLDA_CLASSIFY,
                  BOOSTING_CLASSIFY, BAGGING_CLASSIFY,
                  RF_CLASSIFY, GLMNET_CLASSIFY,
                  TREE_CLASSIFY,
                  MAXENT_CLASSIFY)

# analytics
analytics <- create_analytics(container,CLASSIFY)
summary(analytics)
create_ensembleSummary(analytics@document_summary)










# 形成DocTermMatrix
song.sweet.dtm <- dtm(song.sweet)$DocTermMatrix
song.sad.dtm <- dtm(song.sad)$DocTermMatrix

# 画词云

song.sweet.wordcloud <- wordCloud(song.sweet.dtm)
song.sad.wordcloud <- wordCloud(song.sad.dtm)



