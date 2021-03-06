
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

test=read.csv('xu773d.csv')[,-1]

library(pls)
fit=plsr(as.matrix(Y)~as.matrix(X),ncomp=6)

cf=fit$coefficients[,,1]
pred=as.matrix(test,nrow=1) %*% cf

x=pred[(0:1575*3+1)]
y=pred[(0:1575*3+2)]
z=pred[(0:1575*3+3)]



open3d()

plot3d(x,y,z,type='p')
#text3d(x0,y0,pred,texts=0:76,color=2:78)
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
write.table(savedata,'xufacedata70.txt',sep = ' ',row.names = F,quote = F)
