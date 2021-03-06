
library(rgl)
setwd('c:/rec/denserec/')
TrainSparse=read.csv('TrainDataSparseMorphoSim.csv')
TrainDense=read.csv('TrainDataDenseMorphoSim.csv')
X=TrainSparse[,-1]
Y=TrainDense[,-1]


test=read.csv('xu773d.csv')[,-1]
#test=read.csv('test1.csv')[,-1]
#test=Y[2,]

library(Morpho)
fit=pls2B(X,Y,useCor = F)
predict=predictPLSfromData(fit,x=as.matrix(test),ncomp=2)


pred=predict[1,]

x=pred[(0:1575*3+1)]
y=pred[(0:1575*3+2)]
z=pred[(0:1575*3+3)]



open3d()

plot3d(x,y,z,type='p')
#text3d(x0,y0,pred,texts=0:76,color=2:78)
aspect3d(0.66,1,0.8)
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
write.table(savedata,'testres.txt',sep = ' ',row.names = F,quote = F)
