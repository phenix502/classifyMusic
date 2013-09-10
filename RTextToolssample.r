library(RTextTools) # LOAD THE RTextTools PACKAGE
set.seed(95616) # SET THE SEED FOR REPLICABILITY

url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/breast-cancer-wisconsin.data"
data <- read.csv(url,header=FALSE)  		# GET THE BREAST CANCER DATA

data <- data[-1]					# STRIP PATIENT IDs
diagnosis <- data[,10]					# GET THE DEPENDENT VARIABLE: THE DIAGNOSIS
characteristics <- data[,1:9]				# GET THE CHARACTERISTICS OF THE MASS

# ADD IDENTIFIERS FOR EACH MASS CHARACTERISTIC FOR THE DOCUMENT-TERM MATRIX
# E.G. A=CLUMP THICKNESS, B=UNIFORMITY OF CELL SIZE, C=MARGINAL ADHESION, ETC.
identifiers <- letters[seq(from=1, to=ncol(characteristics))]
characteristics <- t(apply(t(characteristics),2,paste0,identifiers,sep=""))

data <- cbind(characteristics,diagnosis)		# ASSEMBLE OUR CLEANED DATASET
sample <- data[sample(1:nrow(data),size=600,replace=FALSE),] # TAKE A RANDOM SAMPLE

# CREATE A MATRIX OF PATIENTS AND THEIR MASS CHARACTERISTICS (COLUMNS 1-9)
matrix <- create_matrix(sample[,1:9], language="english", removeNumbers=FALSE, stemWords=FALSE, removePunctuation=FALSE, weighting=weightTfIdf, minWordLength=2)

# CREATE A CONTAINER THAT HOLDS OR TRAINING AND TESTING SAMPLES
# THE DIAGNOSIS (COLUMN 10) IS THE DEPENDENT VARIABLE
# DEFINE A 200 PATIENT TRAINING SET AND A 400 PATIENT TESTING SET.
container <- create_container(matrix,sample[,10],trainSize=1:200, testSize=201:600,virgin=FALSE)

# WE RUN OUR LEARNING ALGORITHMS AS A BATCH (SEVERAL ALGORITHMS AT ONCE)
models <- train_models(container, algorithms=c("MAXENT","SVM","GLMNET","SLDA","TREE","BAGGING","BOOSTING","RF"))
results <- classify_models(container, models)

# VIEW THE RESULTS BY CREATING ANALYTICS
analytics <- create_analytics(container, results)
summary(analytics)