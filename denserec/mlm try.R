a=matrix(0:41+rnorm(42,0,0.2),nrow=7)
b=matrix(0:55+20+rnorm(56,0,0.2),nrow=7)
a=as.data.frame(a)
b=as.data.frame(b)
alabs=c('a1','a2','a3','a4','a5','a6')
blabs=c('b1','b2','b3','b4','b5','b6','b7','b8')
names(a)=alabs
names(b)=blabs
f=lm(as.matrix(b)~as.matrix(a))
c=data.frame(a1=44,a2=40,a3=12,a4=21,a5=6,a6=7)

c=as.matrix(cbind(1,c))
c %*% f$coefficient

c2=as.matrix(cbind(1,a))
b2=c2 %*% f$coefficient
  