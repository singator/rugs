##Time-stamp: <2015-08-07 Teckpor>
##Example inspired by pg546 of "The Elements of Statistical Learning"
library(ggplot2)

set.seed(4)
n <- 100
n2 <- 2*n
fConst <- 0.05
matSigma <- cbind(c(fConst, 0), c(0, fConst))

#Generation of data (1st group)
vecRho <- sqrt(runif(n, 0.99, 1.01))
vecTheta <- runif(n, 0, 2*pi)
matNoise1 <- MASS::mvrnorm(n, mu = c(0, 0), Sigma = matSigma)
matGroup1 <- cbind(vecRho*cos(vecTheta), vecRho*sin(vecTheta)) + matNoise1

#Generation of data (2nd group)
vecRho <- 5*sqrt(runif(n, 0.99, 1.01))
vecTheta <- runif(n, 0, 2*pi)
matNoise2 <- MASS::mvrnorm(n, mu = c(0, 0), Sigma = matSigma)
matGroup2 <- cbind(vecRho*cos(vecTheta), vecRho*sin(vecTheta)) + matNoise2

matGroups <- rbind(matGroup1, matGroup2)
#Actual code to cluster data
objKKmeans <- kernlab::kkmeans(matGroups, centers = 2, kernel = "rbfdot")
vecMembership <- as.integer(objKKmeans)

vecColour <- factor(c(rep(0, n2), vecMembership))
levels(vecColour) <- c("#222222", "#1b9e77", "#d95f02", "#7570b3")

vecPanel <- factor(c(rep(1, n2), rep(2, n2)))
levels(vecPanel) <- c("Original Data", "Clustering Results")

dfPlot <- data.frame(x = c(matGroups[, 1], matGroups[, 1]), y = c(matGroups[, 2], matGroups[, 2]), colour = vecColour, panel = vecPanel)
#Plot generation using ggplot2
plotOut <- ggplot(dfPlot, aes(x, y, colour = colour)) +
  geom_point() +
  scale_colour_manual(values = c("#222222", "#1b9e77", "#d95f02"), name = "Legend", labels = c("Data", "Cluster 1", "Cluster 2")) +
  labs(x = "x", y = "y", shape = "", colour = "Legend") +
  theme_bw() +
  facet_grid(panel ~ .) +
  ggtitle("Example 4")
print(plotOut)
ggsave(filename = "example4.pdf", plot = plotOut, width = 11.2, height = 7.77, units = "in")
