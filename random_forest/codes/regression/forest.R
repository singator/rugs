#install.packages("randomForest")
#library(randomForest)

# finally, the random forest model
rf.mod<-randomForest(price ~ ., data = imp.train,
                     mtry = floor((num.var - 1) / 3), # 7; only difference from bagging is here
                     ntree = 300,
                     importance = TRUE)
beep()

# Out-of-bag (OOB) error rate as a function of num. of trees
plot(rf.mod$mse, type = "l", lwd = 3, col = "blue",
     main = "Random forest: OOB estimate of error rate",
     xlab = "Number of Trees", ylab = "OOB error rate")

# tuning the mtry hyperparamter:
tuneRF(subset(imp.train, select = -price),
       imp.train$price,
       ntreetry = 100)
title("Random forest: Tuning the mtry hyperparameter")

# variable importance
varImpPlot(rf.mod,
           main = "Random forest: Variable importance")

# let's make some predictions
rf.pred <- predict(rf.mod,
                   subset(imp.test, select = -price))

# Comparing our predictions with test data:
plot(rf.pred, imp.test$price, main = "Random forest: Actual vs. predicted")
abline(a = 0, b = 1)

# MSE of RF model
print(rf.mse <- mean((rf.pred - imp.test$price) ** 2))
