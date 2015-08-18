library(mixOmics)
library(rgl)
setwd('c:/rec/denserec/')
TrainSparse=read.csv('TrainDataSparse.csv')
TrainDense=read.csv('TrainDataDense.csv')
X=TrainSparse[,-1]
Y=TrainDense[,-1]


test=read.csv('test1.csv')[,-1]


fit=pls(X,Y,mode='regression',ncomp=7,max.iter = 10000)
pred=predict(fit,test)$predict[,,2]

x=pred[(0:1575*3+1)]
y=pred[(0:1575*3+2)]
z=pred[(0:1575*3+3)]

#x=Y[2,(0:1575*3+1)]
#y=Y[2,(0:1575*3+2)]
#z=Y[2,(0:1575*3+3)]


open3d()

plot3d(x,y,z,type='p')
#text3d(x0,y0,pred,texts=0:76,color=2:78)
aspect3d(0.80,1,1)

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

#browseURL(paste("file://", writeWebGL(dir=file.path("C:/rec/", "testres"), width=700), sep=""))

