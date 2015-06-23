# for comparison purposes, consider also a regression model
ols.mod <- lm(price ~ ., data = imp.train)

# predictions
ols.pred <- predict(ols.mod,
                   subset(imp.test, select = -price))

# comparisons with test data:
plot(ols.pred, imp.test$price, main = "OLS: Actual vs. predicted")
abline(a = 0, b = 1)

# MSE
print(ols.mse <- mean((ols.pred-imp.test$price) ** 2))
