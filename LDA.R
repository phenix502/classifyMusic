library(topicmodels)
k = 8;
SEED = 1234;
myDtm = song.corpus.dtm;
my_TM = list(
  VEM = LDA(myDtm, k = k, control = list(seed = SEED)),
  VEM_fixed = LDA(myDtm, k = k,control = list(estimate.alpha = FALSE, seed = SEED)),
  Gibbs = LDA(myDtm, k = k, method = "Gibbs",control = list(seed = SEED, burnin = 1000,
                                                            thin = 100, iter = 1000)),
  CTM = CTM(myDtm, k = k, control = list(seed = SEED,var = list(tol = 10^-4), 
                                         em = list(tol = 10^-3))));

Topic = topics(my_TM[["VEM"]], 1);

#top 5 terms for each topic in LDA
Terms = terms(my_TM[["VEM"]], 5);
Terms;
(my_topics = topics(my_TM[["VEM"]]));

most_frequent = which.max(tabulate(my_topics));

terms(my_TM[["VEM"]], 10)[, most_frequent];
