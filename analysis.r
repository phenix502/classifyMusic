
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

GLMNET.song <- train_model(container.song, "GLMNET")
SLDA <- train_model(container.song, "SLDA")
BOOSTING.song <- train_model(container.song, "BOOSTING")
BAGGING.song <- train_model(container.song, "BAGGING")
RF.song <- train_model(container.song, "RF")
NNET.song <- train_model(container.song, "NNET")


# classifying data using trained models
SVM_CLASSIFY.song <- classify_model(container.song, SVM.song)
TREE_CLASSIFY.song <- classify_model(container.song, TREE.song)
MAXENT_CLASSIFY.song <- classify_model(container.song, MAXENT.song)

GLMNET_CLASSIFY.song <- classify_model(container.song, GLMNET.song)
# SLDA_CLASSIFY <- classify_model(container.song, SLDA)
BOOSTING_CLASSIFY <- classify_model(container.song, BOOSTING.song)
BAGGING_CLASSIFY <- classify_model(container.song, BAGGING.song)
RF_CLASSIFY <- classify_model(container.song, RF.song)
NNET_CLASSIFY <- classify_model(container.song, NNET.song)


CLASSIFY.song <- cbind(SVM_CLASSIFY.song,MAXENT_CLASSIFY.song,TREE_CLASSIFY.song, RF_CLASSIFY
                       ,GLMNET_CLASSIFY.song, BOOSTING_CLASSIFY, BAGGING_CLASSIFY)

# analytics
analytics.song <- create_analytics(container.song,CLASSIFY.song)


newdata <- subset(analytics.song@document_summary, select=c(SVM_LABEL, FORESTS_LABEL, MANUAL_CODE, CONSENSUS_CODE))
a <- newdata$SVM_LABEL==newdata$MANUAL_CODE
precision <- length(a[a==TRUE])/length(newdata$SVM_LABEL)


table(newdata$MANUAL_CODE, newdata$CONSENSUS_CODE)
table(newdata$MANUAL_CODE, newdata$SVM_LABEL)