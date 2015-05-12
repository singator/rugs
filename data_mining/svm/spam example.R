###############################################################################
# loading library
# if kernlab package is not installed
#install.packages("kernlab")
library(kernlab)







###############################################################################
# accessing data
# load the inbuil dataset
data(spam)

#read csv file from local folder
#setwd("C:/Users/alexxbyou/Documents/SVM theory and R application")
#spam <- read.table("spam.csv",sep=",",header=T)

#see spam in the table
View(spam)


# divide the spam data into the training set and testing set
# shuffle the row index

#?sample
index <- sample(1:nrow(spam))
# example: sample(1:10)
head(index,20L)

# taking the first half as training set
spamtrain <- spam[index[1:floor(dim(spam)[1]/2)], ]
#column names of the table
names(spamtrain)

# see the row name in the table
View(spamtrain)

# how many of the emails are spam emails
table(spamtrain$type)

# testing set
spamtest <- spam[index[((ceiling(dim(spam)[1]/2)) + 1):dim(spam)[1]], ]
View(spamtest)




###########################################################
# training SVM

#function instruction 
?ksvm

# system.time(filter <- ksvm(type~.,data=spamtrain,kernel="rbfdot",kpar=list(sigma=0.05),C=5,cross=3))
filter <- ksvm(type~.,data=spamtrain,kernel="rbfdot",kpar=list(sigma=0.05),C=5,cross=3)
filter

## result interpretation

## show all results
str(filter)

#number of SV
filter@nSV

# row numbers of boundary point (support vector)
head(unlist(filter@alphaindex),10L)
#number of SV
length(unlist(filter@alphaindex))

# see support vectors
View(spam[index[unlist(filter@alphaindex)], ])

# importance of the boundary points
unlist(filter@alpha)


## calculating coefficients
# filter@nSV
spamtrain.scale = spamtrain[,-58]/unlist(filter@scaling$x.scale$`scaled:scale`)-unlist(filter@scaling$x.scale$`scaled:center`)

# coefficients
spamtrain.scale.sv = spamtrain.scale[unlist(filter@alphaindex),]
y_mat = filter@ymatrix
y_mat[y_mat==2] = -1
y_mat.sv = y_mat[unlist(filter@alphaindex)]
coef<-as.vector((y_mat.sv*unlist(filter@alpha))%*%matrix(unlist(spamtrain.scale.sv),973,57))
names(coef)<-names(spamtrain.scale.sv)

#coding
View(cbind(head(y_mat),as.character(head(spamtrain[,58]))))

# top 5 features for spam emails
head(sort(coef),5)
# top 5 features for non-spam emails
head(sort(coef,decreasing=T),5)

## predict mail type on the test set
mailtype <- predict(filter,spamtest[,-58])
head(mailtype)

# prediction result
View(cbind(truth = spamtest[,58],prediction = mailtype))
## Check results
table(mailtype,spamtest[,58])



##########################################################################
## tuning the model


SVMTune<-function(kernel,kernel.parameter,C){
  filter <- ksvm(type~.,data=spamtrain,kernel=kernel,kpar=kernel.parameter,C=C,cross=3,prob.model=T)
  mailtype <- predict(filter,spamtest[,-58])
  ConfussionMatrix<-table(mailtype,spamtest[,58])
  false<-ConfussionMatrix[2:3]
  false<-c(false,sum(false))
  false.rate<-false/c(sum(ConfussionMatrix[1:2]),sum(ConfussionMatrix[3:4]),sum(ConfussionMatrix))
  false.rate<-round(false.rate*100,2)
  false.rate<-paste(false.rate,"%",sep="")
  names(false.rate)<-c("nonspam->spam","spam->nonspam","False rate")
  return(false.rate)
}

## Gaussian Kernel
SVMTune("rbfdot",list(sigma=0.0001),5)
SVMTune("rbfdot",list(sigma=0.001),5)
SVMTune("rbfdot",list(sigma=0.01),5)
SVMTune("rbfdot",list(sigma=0.03),5)
SVMTune("rbfdot",list(sigma=0.05),5)
SVMTune("rbfdot",list(sigma=0.07),5)

## Polynomial Kernel
SVMTune("polydot",list(degree=1),5)
SVMTune("polydot",list(degree=2),5)
SVMTune("polydot",list(degree=3),5)
SVMTune("polydot",list(degree=4),5)
SVMTune("polydot",list(degree=5),5)

