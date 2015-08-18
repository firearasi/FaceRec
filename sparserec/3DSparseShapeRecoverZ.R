library(mixOmics)
library(rgl)
setwd('c:/rec/sparserec/')
Train2D=read.csv('TrainData2D.csv')
Train3D=read.csv('TrainData3D.csv')
X=Train2D[,-1]
Y=Train3D[,-1]
Y=Y[,(0:76)*3+3]

test=read.csv('xu772d.csv')[,-1]
#test=X[3,]

fit=pls(X,Y,mode='regression',ncomp = 4,max.iter = 10000)
pred=predict(fit,test)$predict[,,2]



x0=test[2*(0:76)+1]
y0=-test[2*(0:76)+2]
z0=pred
g=list()
g[[1]]=c(1:16,1)
g[[2]]=c(17:22,17)
g[[3]]=c(23:28,23)
g[[4]]=c(31:38,31)
g[[5]]=c(41:48,41)
g[[6]]=c(60:66,73:77,60)
g[[7]]=c(67:72,67)
g[[8]]=c(49,55,56,57,58,59,51,49)
g[[9]]=c(50,54,53,52,50,53)
open3d()

plot3d(x0,y0,pred,type='p')
#text3d(x0,y0,pred,texts=0:76,color=2:78)
aspect3d(0.82,1,0.6)
for(k in 1:9) {
lines3d(x0[g[[k]]],y0[g[[k]]],pred[g[[k]]])
}
#browseURL(paste("file://", writeWebGL(dir=file.path("C:/rec/", "testres"), width=700), sep=""))

