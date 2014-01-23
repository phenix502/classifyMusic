
# 1 表示sad 2表示sweet
label <- c(rep(1L,764), rep(2L, 861))
lable <- factor(label)
#  从伤感歌词中挑选64首作为测试集，同理甜蜜类挑选61首作为测试集
sad.test <- sample(1:764, 64, replace= FALSE)
sweet.test <-sample(765:1625,61,replace= FALSE)
testSize <- c(sad.test,sweet.test)
trainSize <- 1:1625
trainSize <- trainSize[-test]
# create a container
container.song <- create_container(corpus.dtm.tfidf, label,
                                   trainSize=trainSize, testSize=testSize, virgin=FALSE)

# training models
SVM.song <- train_model(container.song, "SVM")
RF.song <- train_model(container.song, "RF")

# classifying data using trained models
SVM_CLASSIFY.song <- classify_model(container.song, SVM.song)
RF_CLASSIFY.song <- classify_model(container.song, RF.song)


create_precisionRecallSummary(container=container.song, classification_results=SVM_CLASSIFY.song)
create_precisionRecallSummary(container=container.song, classification_results=RF_CLASSIFY.song)

