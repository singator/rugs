# packages that we will need this evening:
#  @ kernlab:      for the spam dataset
#  @ tree:         for decision tree construction
#  @ randomForest: for bagging and RF
#  @ beepr:        for a little beep
#  @ pROC:         for plotting of ROC

# code snippet to install and load multiple packages at once
#pkgs <- c("kernlab","tree","randomForest","beepr","pROC")
#sapply(pkgs,FUN=function(p){
#        print(p)
#        if(!require(p)) install.packages(p)
#        require(p)
#})

# load required packages
library(kernlab)
library(tree)
library(randomForest)
library(beepr) # try it! beep()
library(pROC)

# load dataset
data(spam)

# take a look
str(spam)
#View(spam)

# preparation for cross validation:
# split the dataset into 2 halves,
# 2300 samples for training and 2301 for testing
num.samples <- nrow(spam) # 4,601
num.train   <- round(num.samples/2) # 2,300
num.test    <- num.samples - num.train # 2,301
num.var     <- ncol(spam) # 58

# set up the indices
set.seed(150715)
idx       <- sample(1:num.samples)
train.idx <- idx[seq(num.train)]
test.idx  <- setdiff(idx,train.idx)

# subset the data
spam.train <- spam[train.idx,]
spam.test  <- spam[test.idx,]

# take a quick look
str(spam.train)
str(spam.test)
table(spam.train$type)
table(spam.test$type)
