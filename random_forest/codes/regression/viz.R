# Comparing MSEs of various models:
barplot(c(tree.mse,
          bg.mse,
          rf.mse,
          ols.mse),
        main = "Mean squared errors of various models",
        names.arg = c("Tree", "Bagging", "RF", "OLS"))
