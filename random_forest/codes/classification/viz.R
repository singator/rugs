barplot(c(tree.accuracy,
          bg.accuracy,
          rf.accuracy,
          log.accuracy),
        main="Accuracies of various models",
        names.arg=c("Tree","Bagging","RF", "Logistic"))

# plot ROC curve + AUC
# (Receiver operating characteristic) (Area under curve)
# Note that this cannot be done for decision tree models,
# because the ROC is only valid for models that give
# probabilistic output
bg.pred.prob <- predict(bg.mod ,
                        subset(spam.test,select=-type),
                        type="prob")

rf.pred.prob <- predict(rf.mod ,
                        subset(spam.test,select=-type),
                        type="prob")

plot.roc(spam.test$type,
         bg.pred.prob[,1], col = "blue",
         lwd = 3, print.auc = TRUE, print.auc.y = 0.3,
         main = "ROC-AUC of various models")

plot.roc(spam.test$type,
         rf.pred.prob[,1], col = "green",
         lwd = 3, print.auc = TRUE, print.auc.y = 0.2,
         add = TRUE)

plot.roc(spam.test$type,
         log.pred.prob, col = "red",
         lwd = 3, print.auc = TRUE, print.auc.y = 0.1,
         add = TRUE)

legend(x = 0.6, y = 0.8, legend = c("Bagging",
                                    "Random forest",
                                    "Logistic regression"),
       col = c("blue", "green", "red"), lwd = 1)
