
library(rgl)
library(RSNNS)
setwd('c:/rec/denserec/')
TrainSparse=read.csv('TrainDataSparseMorphoSim.csv')
TrainDense=read.csv('TrainDataDenseMorphoSim.csv')
X=TrainSparse[,-1]
Y=TrainDense[,-1]


test=read.csv('xu773d.csv')[,-1]
#test=read.csv('test1.csv')[,-1]
#test=Y[2,]

prX=prcomp(X,retx=T)
prY=prcomp(Y,retY=T)
pcX=prX$x
pcY=prY$x

pcx=as.matrix(pcX)
pcy=as.matrix(pcY)

#l=solve(t(pcx)%*%pcy) %*% t(pcx) %*% pcy

#pctest=matrix(predict(prX,test)[1:2],nrow=1)
#pctesty=pctest%*% l

nnet<-mlp(pcX,pcY,size=5)
pctestx<-predict(prX,test)
pctesty<-predict(nnet,pctestx)

eigY=t(prY$rotation)
predict=pctesty%*%eigY+prY$center

pred=prY$center

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
  lines3d(x[f],y[f],z[f],color='blue')
}

#browseURL(paste("file://", writeWebGL(dir=file.path("C:/rec/", "test1"), width=700), sep=""))
v=rep('v',1576)
savedata=data.frame(v,x,y,z)
write.table(savedata,'xupcann.txt',sep = ' ',row.names = F,quote = F)
