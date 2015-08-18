library(mixOmics)
library(rgl)
setwd('c:/rec/sparserec')


dat=read.delim('vertex5.txt',sep=' ',header=F)

x0=dat$V1

y0=dat$V2
z0=dat$V3
g=list()
g[[1]]=c(1:16,1)
g[[2]]=c(17:22,17)
g[[3]]=c(23:28,23)
g[[4]]=c(31:38,31)
g[[5]]=c(41:48,41)
g[[6]]=c(60:66,73:77,60)
g[[7]]=c(66:72,66)
g[[8]]=c(49,55,56,57,58,59,51,49)
g[[9]]=c(50,54,53,52,50,53)
plot3d(x0,y0,z0,type='p')
#text3d(x0,y0,z0,texts=0:76)
text3d(x0,y0,z0,texts=0:76,color=2:78)

for(k in 1:9) {
lines3d(x0[g[[k]]],y0[g[[k]]],z0[g[[k]]])
}
#browseURL(paste("file://", writeWebGL(dir=file.path("C:/rec/", "testres"), width=700), sep=""))

