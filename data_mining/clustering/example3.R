##Time-stamp: <2015-08-04 Teckpor>
##Example data sets inspired by:
##http://stats.stackexchange.com/questions/79741/data-sets-suitable-for-k-means
library(ggplot2)

set.seed(3)
n <- 100
n3 <- 3*n
fConst <- 0.5
fConstNoise <- 0.5
fDisplacement <- 1

#Generation of data (1st group)
vecXNoise <- runif(n)
vecYNoise <- runif(n)
vecSinX <- seq(from = -pi, to = pi, length.out = n)
vecSinY <- -sin(vecSinX)
vecX <- 0.1*(vecSinX + fConstNoise*vecXNoise)
vecY <- 0.2*(vecSinY + fConstNoise*vecYNoise)
matGroup1 <- cbind(vecX - fDisplacement, vecY + fDisplacement)

#Generation of data (2nd group)
vecRho <- sqrt(runif(n))
vecTheta <- runif(n, 0, 1)  + 1
matGroup2 <- cbind(fConst*vecRho*cos(vecTheta) - fDisplacement, fConst*vecRho*sin(vecTheta) - fDisplacement)

#Generation of data (3rd group)
vecX <- runif(n)
vecY <- runif(n)
matGroup3 <- cbind(vecX, vecY)

matGroups <- rbind(matGroup1, matGroup2, matGroup3)
#Actual code to cluster data
listKmeans <- kmeans(matGroups, centers = 3, algorithm = "Lloyd")

vecColour <- factor(c(rep(0, n3), listKmeans$cluster))
levels(vecColour) <- c("#222222", "#1b9e77", "#d95f02", "#7570b3")

vecPanel <- factor(c(rep(1, n3), rep(2, n3)))
levels(vecPanel) <- c("Original Data", "Clustering Results")

dfPlot <- data.frame(x = c(matGroups[, 1], matGroups[, 1]), y = c(matGroups[, 2], matGroups[, 2]), colour = vecColour, panel = vecPanel)
#Plot generation using ggplot2
plotOut <- ggplot(dfPlot, aes(x, y, colour = colour)) +
  geom_point() +
  scale_colour_manual(values = c("#222222", "#1b9e77", "#d95f02", "#7570b3"), name = "Legend", labels = c("Data", "Cluster 1", "Cluster 2", "Cluster 3")) +
  labs(x = "x", y = "y", shape = "", colour = "Legend") +
  theme_bw() +
  facet_grid(panel ~ .) +
  ggtitle("Example 3")

print(plotOut)
ggsave(filename = "example3.pdf", plot = plotOut, width = 11.2, height = 7.77, units = "in")
