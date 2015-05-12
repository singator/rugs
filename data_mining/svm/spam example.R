#! /usr/bin/env R

###############################################################################
# load library
# if kernlab package is not installed
#install.packages("kernlab")
library(kernlab)



# load the inbuil dataset
data(spam)

#see spam in the table
View(spam)




################################################################################
# divide the spam data into the training set and testing set
# shuffle the row index
index <- sample(1:nrow(spam))
head(index,20L)

# taking the first half as training set
spamtrain <- spam[index[1:floor(dim(spam)[1]/2)], ]
View(spamtrain)

# testing set
spamtest <- spam[index[((ceiling(dim(spam)[1]/2)) + 1):dim(spam)[1]], ]
View(spamtest)


###########################################################
# training SVM

#function instruction 
?ksvm

# system.time(filter <- ksvm(type~.,data=spamtrain,kernel="rbfdot",kpar=list(sigma=0.05),C=5,cross=3))
filter <- ksvm(type~.,data=spamtrain,kernel="rbfdot",kpar=list(sigma=0.05),C=5,cross=3,prob.model=T)
filter


## result interpretation

#number of SV
filter@nSV

# row numbers of boundary point (support vector)
head(unlist(filter@alphaindex),10L)
length(unlist(filter@alphaindex))

# see support vectors
View(spam[index[unlist(filter@alphaindex)], ])

#importance of the boundary points
unlist(filter@alpha)




#########################################################################
## predict mail type on the test set
mailtype <- predict(filter,spamtest[,-58])
head(mailtype)

# prediction result
View(cbind(truth = spamtest[,58],prediction = mailtype))
## Check results
table(mailtype,spamtest[,58])












