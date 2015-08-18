
library(rgl)
setwd('c:/rec/denserec/')
TrainSparse=read.csv('TrainDataSparseMorphoSim.csv')
TrainDense=read.csv('TrainDataDenseMorphoSim.csv')
X=TrainSparse[,-1]
Y=TrainDense[,-1]


test=read.csv('xu773d.csv')[,-1]
#test=read.csv('test1.csv')[,-1]
#test=Y[2,]

prX=prcomp(X)

#od=prX$x%*%t(prX$rotation)+prX$center

prY=prcomp(Y)
pcX=prX$x[,1:5]
pcY=prY$x[,1:5]

pcx=as.matrix(pcX)
pcy=as.matrix(pcY)

l=solve(t(pcx)%*%pcx) %*% t(pcx) %*% pcy

pctest=matrix(predict(prX,test)[1:5],nrow=1)
pctesty=pctest%*% l

eigY=t(prY$rotation)

#Using only the first 3 PC's, adding the 4th PC would be horrible
#tune here
predict=matrix(c(pctesty[1:3],-2,-0.1932,0),nrow=1,ncol=6) %*% eigY+prY$center
pred=predict

x=pred[(0:1575*3+1)]
y=pred[(0:1575*3+2)]
z=pred[(0:1575*3+3)]

open3d()

plot3d(x,y,z,type='p')

aspect3d(0.76,1,0.8)
title3d('xu')

face=read.csv('face.csv',header=F)
nfaces=nrow(face)

for(k in 1:nfaces) {
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
write.table(savedata,'testpca3.txt',sep = ' ',row.names = F,quote = F)


ll=c(932,817,1133,1384,929,1389,622,625,113,619,343,1,116,160,272,972,1083,911,912,1094,1002,819,3,293,95,96,304,197,214,1020,1500,1503,1504,1505,1293,1211,1242,1282,3,4,741,744,745,746,524,630,466,513,756,611,1515,1371,283,604,91,90,174,906,907,1215,1520,1028,225,224,761,436,798,801,1557,1244,478,468,779,231,228,1033,1538)

comparison=c(x[ll[1]],y[ll[1]],z[ll[1]])
for(k in 2:77) comparison=c(comparison,x[ll[k]],y[ll[k]],z[ll[k]])
comparison=rbind(test,comparison)
rownames(comparison)=c('original','computed')
write.csv(comparison,'comparison.csv')
