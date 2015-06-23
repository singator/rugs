#install.packages("randomForest")
#library(randomForest)

# finally, the random forest model
rf.mod <- randomForest(type ~ ., data = spam.train,
                       mtry = floor(sqrt(num.var - 1)), # 7; only difference from bagging is here
                       ntree = 300,
                       proximity = TRUE,
                       importance = TRUE)
beep()

# Out-of-bag (OOB) error rate as a function of num. of trees:
plot(rf.mod$err.rate[,1], type = "l", lwd = 3, col = "blue",
     main = "Random forest: OOB estimate of error rate",
     xlab = "Number of Trees", ylab = "OOB error rate")

# tuning the mtry hyperparameter
tuneRF(subset(spam.train, select = -type),
       spam.train$type,
       ntreetry = 100)
title("Random forest: Tuning the mtry hyperparameter")

# variable importance
varImpPlot(rf.mod,
           main = "Random forest: Variable importance")

# multidimensional scaling plot
# green samples are non-spam,
# red samples are spam
MDSplot(rf.mod,
        fac = spam.train$type,
        palette = c("green","red"),
        main = "Random forest: MDS")
beep()

# now, let's make some predictions
rf.pred <- predict(rf.mod,
                   subset(spam.test,select = -type), 
                   type="class")

# confusion matrix
print(rf.pred.results <- table(rf.pred, spam.test$type))

# Accuracy of our RF model:
print(rf.accuracy <- sum(diag((rf.pred.results))) / sum(rf.pred.results))
