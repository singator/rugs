#install.packages("tree")
#library(tree)

# let's go. Construct a decision tree model
tree.mod <- tree(type ~ ., data = spam.train)

# here's how the model looks like:
plot(tree.mod)
title("Decision tree")
text(tree.mod, cex = 0.75)

# let's see if our decision tree requires pruning
cv.prune <- cv.tree(tree.mod, FUN = prune.misclass)
plot(cv.prune$size, cv.prune$dev, pch = 20, col = "red", type = "b",
     main = "Decision tree: Cross validation to find optimal size of tree",
     xlab = "Size of tree", ylab = "Misclassifications")

# let's choose a tree size of 5
best.tree.size <- 9

# pruning (cost-complexity pruning)
pruned.tree.mod <- prune.misclass(tree.mod, best = best.tree.size)

# here's the new tree model
plot(pruned.tree.mod)
title(paste("Pruned decision tree (", best.tree.size, " leaf nodes)",sep = ""))
text(pruned.tree.mod, cex = 0.75)

# now let's make some predictions
tree.pred <- predict(pruned.tree.mod,
                     subset(spam.test,select = -type), 
                     type="class")

# confusion matrix
# rows are the predicted classes
# columns are the actual classes
print(tree.pred.results <- table(tree.pred, spam.test$type))

# What is the accuracy of our tree model?
print(tree.accuracy <- (tree.pred.results[1,1] + tree.pred.results[2,2]) / sum(tree.pred.results))
