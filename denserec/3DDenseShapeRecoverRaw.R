
library(rgl)
setwd('c:/rec/denserec/')
TrainSparse=read.csv('TrainDataSparse.csv')
TrainDense=read.csv('TrainDataDense.csv')
X=TrainSparse[,-1]
Y=TrainDense[,-1]

XX=rnorm(ncol(X)*nrow(X),mean=0,sd=0.01)
XX=matrix(XX,ncol=ncol(X))
X=X+XX


YY=rnorm(ncol(Y)*nrow(Y),mean=0,sd=0.01)
YY=matrix(YY,ncol=ncol(Y))
Y=Y+YY


#test=read.csv('xu773d.csv')[,-1]
test=X[4,]

X=as.matrix(X)
X=cbind(1,X)
Y=as.matrix(Y)
AA=t(X) %*% X
BB=t(X) %*% Y

cf=solve(AA) %*% BB

pred=cbind(1,as.matrix(test)) %*% cf



x=pred[(0:1575*3+1)]
y=pred[(0:1575*3+2)]
z=pred[(0:1575*3+3)]



open3d()

plot3d(x,y,z,type='p')

aspect3d(0.76,1,0.8)
title3d('xu')

face=read.csv('face.csv',header=F)
l=nrow(face)

for(k in 1:l) {
  f=face[k,]
  #omitting NA values
  f=f[is.na(f)==F]
  #making a cyclic array of polygon vertices
  f=c(f,f[1])
  lines3d(x[f],y[f],z[f],color=k)
}

#browseURL(paste("file://", writeWebGL(dir=file.path("C:/rec/", "test1"), width=700), sep=""))
v=rep('v',1576)
savedata=data.frame(v,x,y,z)
write.table(savedata,'xufacedata.txt',sep = ' ',row.names = F,quote = F)
