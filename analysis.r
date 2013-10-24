
# 1 表示sad 2表示sweet
label <- c(rep(1L,764), rep(2L, 861))

sad.test <- sample(1:764, 64, replace= FALSE)
sweet.test <-sample(765:1625,61,replace= FALSE)
test <- c(sad.test,sweet.test)
# create a container
container.song <- create_container(corpus.dtm.tfidf, label,trainSize=1:1625[-test], testSize=test, virgin=FALSE)

# training models
TREE.song <- train_model(container.song, "TREE")
SVM.song <- train_model(container.song, "SVM")
MAXENT.song <- train_model(container.song, "MAXENT")

GLMNET <- train_model(container.song, "GLMNET")
SLDA <- train_model(container.song, "SLDA")
BOOSTING <- train_model(container.song, "BOOSTING")
BAGGING <- train_model(container.song, "BAGGING")
RF <- train_model(container.song, "RF")
NNET <- train_model(container.song, "NNET")


# classifying data using trained models
SVM_CLASSIFY.song <- classify_model(container.song, SVM.song)
TREE_CLASSIFY.song <- classify_model(container.song, TREE.song)
MAXENT_CLASSIFY.song <- classify_model(container.song, MAXENT.song)

GLMNET_CLASSIFY <- classify_model(container, GLMNET)
SLDA_CLASSIFY <- classify_model(container, SLDA)
BOOSTING_CLASSIFY <- classify_model(container, BOOSTING)
BAGGING_CLASSIFY <- classify_model(container, BAGGING)
RF_CLASSIFY <- classify_model(container, RF)
NNET_CLASSIFY <- classify_model(container, NNET)


CLASSIFY.song <- cbind(SVM_CLASSIFY.song,MAXENT_CLASSIFY.song,TREE_CLASSIFY.song)

# analytics
analytics.song <- create_analytics(container.song,CLASSIFY.song)


