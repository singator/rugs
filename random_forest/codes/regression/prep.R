# Example on using tree-based models in regression problems
# regression as in the predicted variable is continuous / numerical,
# not categorical

library(tree)
library(randomForest)

data(imports85)
imp <- imports85

# The following data preprocessing steps on
# the imports85 dataset are suggested by
# the authors of the randomForest package
# look at
# > ?imports85
imp <- imp[,-2]  # Too many NAs in normalizedLosses.
imp <- imp[complete.cases(imp), ]
# ## Drop empty levels for factors
imp[] <- lapply(imp, function(x) if (is.factor(x)) x[, drop=TRUE] else x)

# Also removing the numOfCylinders and fuelSystem
# variables due to sparsity of data
# to see this, run the following lines:
# > table(imp$numOfCylinders)
# > table(imp$fuelSystem)
# This additional step is only necessary because we will be
# making comparisons between the tree-based models
# and linear regression, and linear regression cannot
# handle sparse data well
imp <- subset(imp, select = -c(numOfCylinders,fuelSystem))

# Preparation for cross validation:
# split the dataset into 2 halves,
# 96 samples for training and 97 for testing
num.samples <- nrow(imp) # 193
num.train   <- round(num.samples / 2) # 96
num.test    <- num.samples - num.train # 97
num.var     <- ncol(imp) # 25

# set up the indices
set.seed(150715)
idx       <- sample(1:num.samples)
train.idx <- idx[seq(num.train)]
test.idx  <- setdiff(idx,train.idx)

# subset the data
imp.train <- imp[train.idx,]
imp.test  <- imp[test.idx,]

str(imp.train)
str(imp.test)

# take a quick look
hist(imp.train$price)
hist(imp.test$price)
# long right tails

# While tree-based methods are scale-invariant
# with respect to predictor variables,
# this is not true for the response variable
# Hence, let's take a log-transformation on price here
imp.train$price <- log(imp.train$price)
imp.test$price <- log(imp.test$price)

# take a look again
hist(imp.train$price)
hist(imp.test$price)
