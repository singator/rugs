#install.packages("randomForest")
#library(randomForest)

# next, let's build a bagging model
bg.mod<-randomForest(type ~ ., data = spam.train,
                     mtry = num.var - 1, # try all variables at each split
                     ntree = 300,
                     proximity = TRUE,
                     importance = TRUE)
beep()

# Out-of-bag (OOB) error rate:
# x-axis: number of trees constructed
# y-axis: the ith OOB error rate of the ensemble
# up to the point where i trees have been constructed
plot(bg.mod$err.rate[,1], type = "l", lwd = 3, col = "blue",
     main = "Bagging: OOB estimate of error rate",
     xlab = "Number of Trees", ylab = "OOB error rate")

# variable importance:
# which variables are more important than others?
varImpPlot(bg.mod,
           main = "Bagging: Variable importance")

# multidimensional scaling plot:
# green samples are non-spam,
# red samples are spam
MDSplot(bg.mod,
        fac = spam.train$type,
        palette = c("green","red"),
        main = "Bagging: MDS")
beep()

# let's make some predictions
bg.pred <- predict(bg.mod,
                   subset(spam.test, select = -type), 
                   type = "class")

# confusion matrix
print(bg.pred.results <- table(bg.pred, spam.test$type))

# what is the accuracy of our bagging model?
print(bg.accuracy <- sum(diag((bg.pred.results))) / sum(bg.pred.results))
