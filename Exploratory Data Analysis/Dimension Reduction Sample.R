
# Dimension Reduction
# PCA / SVC


set.seed(12345)
par(mar = rep(0.2, 4))
dataMatrix <- matrix(rnorm(400), nrow = 40)
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])
heatmap(dataMatrix)
dataMatrix


set.seed(678910)
for (i in 1:40) {
    # flip a coin
    coinFlip <- rbinom(1, size = 1, prob = 0.5)
    # if coin is heads add a common pattern to that row
    if (coinFlip)
    {
      dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 3), each = 5)
    }
}
heatmap(dataMatrix)



hh <- hclust(dist(dataMatrix))
dataMatrixOrderd <- dataMatrix[hh$order, ]
par(mfrow = c(1,3))
image(t(dataMatrixOrderd)[, nrow(dataMatrixOrderd):1])
plot(rowMeans(dataMatrixOrderd), 40:1, , xlab = "Row Mean", ylab = "Row", pch = 19)
plot(colMeans(dataMatrixOrderd), xlab = "Column", ylab = "Column Mean", pch = 19)
