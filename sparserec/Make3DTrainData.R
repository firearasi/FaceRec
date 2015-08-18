setwd('c:/rec/sparserec//')
t=read.csv('TrainData3DTemplate.csv',header=T)
indice=c(2,3,4,5,8,9,10)
j=1
for(i in indice) {
  file=paste0('vertex',i,'.txt')
  f=read.delim(file,header=F,sep=' ')
  d=as.matrix(f)
  dd=c(t(d))
  t[j,]=dd
  j=j+1
}
write.csv(x=t,file = 'TrainData3D.csv')
