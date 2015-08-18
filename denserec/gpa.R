setwd('c:/rec/denserec/')

library(shapes)


A=read.array('comparison2.txt',k=77,m=3,n=1)
xa=A[,1,1]
ya=A[,2,1]
za=A[,3,1]
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

plot3d(xa,ya,za,type='p')
#text3d(x0,y0,pred,texts=0:76,color=2:78)

for(k in 1:9) {
  lines3d(xa[g[[k]]],ya[g[[k]]],za[g[[k]]])
}
