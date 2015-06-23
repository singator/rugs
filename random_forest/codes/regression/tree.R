#install.packages("tree")
#library(tree)

# Construct decision tree model
tree.mod <- tree(price ~ ., data = imp.train)

# here's how the model looks like
plot(tree.mod)
title("Decision tree")
text(tree.mod, cex = 0.75)

# let's see if our decision tree requires pruning
cv.prune <- cv.tree(tree.mod, FUN = prune.tree)
plot(cv.prune$size, cv.prune$dev, pch = 20, col = "red", type = "b",
     main = "Cross validation to find optimal size of tree",
     xlab = "Size of tree", ylab = "Mean squared error")
# looks fine

# now let's make some predictions
tree.pred <- predict(tree.mod,
                     subset(imp.test,select = -price), 
                     type = "vector")

# Comparing our predictions with the test data:
plot(tree.pred, imp.test$price, main = "Decision tree: Actual vs. predicted")
abline(a = 0, b = 1) # A prediction with zero error will lie on the y = x line

# What is the MSE of our model?
print(tree.mse <- mean((tree.pred - imp.test$price) ** 2))
