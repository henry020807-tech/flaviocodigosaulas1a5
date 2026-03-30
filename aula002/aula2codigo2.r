#--------------------------------------------------
rm(list=ls())
#-------------------------------------------------
perceptron<-function(xvec,w,par)
 # Returns the response yo fasingle Perceptron neuron .
 # xvec : Input matrix with N rows and m colunms containing the 
 # data set or a single input vector x , which mat contain
 # or not the additional fixed ????1 element corresponding 
 # to the bias .
 # w: Weight vector 
 # par: if par=1 then x must be augmented by a ????1 colunm .
{
    if (par==1) #Checks par as above 
      xvec<-cbind(-1,xvec) # Augments -1 i f needed
    u<-xvec %*% w
    y<-1.0*((u==0))
    return ((as.matrix(y)))
}
#-------------------------------------------------
#-------------------------------------------------
trainperceptron<-function(xin,yd,eta,tol,maxepocas,par)
    # Trains a s impl e pe r c ept ron .
    # xin : Input Nxn da t a s e t matrix .
    # e ta : Weight update update s t ep .
    # tol : error goal .
    # maxepocas : maximum number o f epochs al lowed .
    # par : par = 1 i n d i c a t e s that ????1 needs to be 
    # agumenteed to xin 
{
    dimxin<-dim(xin)
    N<-dimxin[1]
    n<-dimxin[2]
    if(par==1){
        wt<-as.matrix(runif(n+1)-0.5)
        xin<-cbind(-1,xin)
    }else wt<-as.matrix(runif(n)-0.5)
    nepocas<-0
    eepoca<-tol+1

    #vetor de erro
    evec<-matrix(nrow=1,ncol=maxepocas)
    while((nepocas < maxepocas) && (eepoca > tol))
    {
        ei2<-0
        xseq<-sample(N)
        for(i in 1:N)
        {
            irand<-xseq[i]
            yhati<-1.0*((xin[irand,] %*% wt)>=0)
            ei<-yd[irand]-yhati
            dw<-eta*ei*xin[irand,]
            wt<-wt+dw
            ei2<-ei2+ei*ei
        }
        nepocas<-nepocas+1
        evec[nepocas]<-ei2/N
        eepoca<-evec[nepocas]
    }
    retlist<-list(wt,evec[1:nepocas])
    return(retlist)
}

#----------exemplo-------------------------
#Usar base de dados Iris (focar em transformar 3 tipos em dois tipos)
data(iris)
ntrain<-10
#dividir a base iri (no caso, para treinar, x são as variáveis - os rotulos se tornam y e precisam se tratados)
xc1<-iris[1:50,1:4] #coletar amostras 1 a 50, Imitando-se a 4 variáveis
xc2<-iris[76:125,1:4]#coletar amostras 76 a 125, Imitando-se a 4 variáveis
#Numeros máximo de testes 
maxteste<-20
#erros que serão acumulados
erros<-matrix(0,nrow=maxteste,ncol=100)

#y transformando "setosa" em 0 e "vesicolor" e "virginica" em 1
ytt<-matrix(0,nrow=100-(ntrain*2),ncol=maxteste)
#iniciando os pesos em wt
wtt<-matrix(0,nrow=5,ncol=maxteste)

for(t in 1:maxteste){
    #gerando uma primeira lista aleatória de indices de 1 a 50
    seqc1<-sample(50)
    #embaralhando a entrada x de treinamento com a sequencia aleatória que foi gerada 
    xc1treina<-xc1[seqc1[1:ntrain],]
    #embaralhando as respostas y de treinamento com a sequencia aleatória que foi gerada - sincronizada com x 
    yc1treina<-matrix(0,nrow=ntrain)

    seqc2<-sample(50)
    xc2treina<-xc2[seqc2[1:ntrain],]
    yc2treina<-matrix(1,nrow=ntrain)

    #BASE COM CASO IGUAL A 0
    xc1teste<-xc1[seqc1[(ntrain+1):50],]
    yc1teste<-matrix(0,nrow=(50-ntrain))
    #BASE COM CASO IGUAL A 1 
    xc2teste<-xc2[seqc2[(ntrain+1):50],]
    yc2teste<-matrix(1,nrow=(50-ntrain))

    xin<-as.matrix(rbind(xc1treina,xc2treina))
    yd<-rbind(yc1treina,yc2treina)

    yinteste<-as.matrix(rbind(xc1teste,xc2teste))
    yteste<-rbind(yc1teste,yc2teste)

    retlist<-trainperceptron(xin,yd,0.1,0.01,100,1)

    wt<-as.matrix(unlist(retlist[1]))
    wtt[1:length(wt),t]<-wt[1:length(wt)]

    yt<-perceptron(yinteste,wt,1)
    ytt[1:length(yt),t]<-yt[1:length(yt)]

    erroteste<-as.matrix(unlist(retlist[2]))
#plot(erroteste,type='l')
#plot(yt,type='l')
a<-1
for(a in 1:length(erroteste)){
    erros[t,a]<-erroteste[a]
    }
}
#Erros M?dios considerando o n?mero m?ximo de ?pocas
errosmedios<-matrix(0,nrow=100)

for(b in 1:100){
    errosmedios[b]<-mean(erros[1:maxteste,b])
    }

plot(errosmedios,type='l',xlab='número total de épocas',ylab='médiade erros',main='Média de Erros x ?pocas')

boxplot(erros[,1:10],main='Boxplot Erros',xlab='?pocas',ylab="Erros")
#Média das respostas de classificação
yttmedios<-matrix(0,nrow=100-(2*ntrain))
for(b in 1:(100-(2*ntrain))){
    yttmedios[b]<-mean(ytt[b,1:maxteste])
}
#Mostrandoa classificação em comparação com as amostras
plot(yttmedios, type='l',xlab='Amostras de Análise',ylab='', main=cbind('classificação: ',maxteste,' Experimentos'))
par(new=T)
plot(yteste, type='p',xlab='Amostras de Análise',ylab='', main=cbind('classificação: ',maxteste,' Experimentos'))

#variancia Erros Médios considerando o número máximo de épocas
errosvar<-matrix(0,nrow=100)
for(b in 1:100){
    errosvar[b]<-var(erros[1:maxteste,b])
    }

plot(errosvar[1:5],type='l',xlab='número total de ?pocas',ylab='variância de erros',main='variância de Erros x épocas')

#Média Pesos considerando o número maximo de épocas
wttmedios<-matrix(0,nrow=5)

for(c in 1:5){
    wttmedios[c]<-mean(wtt[c,1:maxteste])
    }
    plot(wttmedios, type='b',xlab='w',ylab='valor m?dio', main=cbind('classifica??o: ',maxteste,' Experimentos - valores m?dios de w'))
#variância Pesos considerando o número máximo de épocas 
wttvar<-matrix(0,nrow=5)

for(c in 1:5){wttvar[c]<-var(wtt[c,1:maxteste])}
plot(wttvar, type='b',xlab='w',ylab='vari?ncia', main=cbind('classificação: ',maxteste,' Experimentos - variância de w'))
