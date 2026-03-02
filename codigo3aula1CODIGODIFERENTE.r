w1<-1
w2<-1

# CULPADO 1 REMOVIDO DAQUI
#plot(xt[,1],xt[,2],type='l',col='black',xlim=c(0,6),ylim=c(0,6),xlab='x1',ylab='x2')

library('plot3D')

seqi<-seq(0,10,0.1)
seqj<-seq(0,10,0.1)
M1<-matrix(1,nrow=length(seqi),ncol=length(seqj))
ci<-0
for (i in seqi)
{
    ci<-ci+1
    cj<-0
    for (j in seqj)
    {
        cj<-cj+1
        M1[ci,cj]<-1.0*((pdf2var(i,j,m11,d11,m12,d12,0)*w1)>(pdf2var(i,j,m21,d21,m22,d22,0)*w2))
    }
}
persp3D(seqi,seqj,M1,add=FALSE)

################################Densidade de xc1################################
# CULPADO 2 REMOVIDO DAQUI
m1<-mean(xc1[,1])
m2<-mean(xc1[,2])
d1<-sd(xc1[,1])
d2<-sd(xc1[,2])

seqi<-seq(0,10,0.1)
seqj<-seq(0,10,0.1)
M<-matrix (1,nrow=length(seqi),ncol=length(seqj))
ci<-0
for (i in seqi)
{
    ci<-ci+1
    cj<-0
    for (j in seqj)
    {
        cj<-cj+1
        M[ci,cj]<-pdf2var(i,j,m1,d1,m2,d2,0)
    }
}
# CULPADO 3 REMOVIDO DAQUI
persp3D(seqi,seqj,M,add=TRUE)

################################Densidade de xc2################################
# CULPADO 4 REMOVIDO DAQUI
m1<-mean(xc2[,1])
m2<-mean(xc2[,2])
d1<-sd(xc2[,1])
d2<-sd(xc2[,2])

seqi<-seq(0,10,0.1)
seqj<-seq(0,10,0.1)
M2<-matrix(1,nrow=length(seqi),ncol=length(seqj))
ci<-0
for (i in seqi)
{
    ci<-ci+1
    cj<-0
    for (j in seqj)
    {
        cj<-cj+1
        M2[ci,cj]<-pdf2var(i,j,m1,d1,m2,d2,0)
    }
}
persp3D(seqi,seqj,M2,add=T)