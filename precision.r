Cal_precision <- function(x){
  label <- factor(c(rep(1,97)), levels = c(1,2), labels = c("sweet","sad"))
  precision <- length(x[x==label])/97
  return(precision)
}

Cal_precision(SVM_CLASSIFY$SVM_LABEL) 
Cal_precision(SLDA_CLASSIFY$SLDA_LABEL) 
Cal_precision(BOOSTING_CLASSIFY$LOGITBOOST_LABEL) 
Cal_precision(BAGGING_CLASSIFY$BAGGING_LABEL) 
Cal_precision(RF_CLASSIFY$FORESTS_LABEL) 
Cal_precision(TREE_CLASSIFY$TREE_LABEL) 
Cal_precision(MAXENT_CLASSIFY$MAXENTROPY_LABEL) 
