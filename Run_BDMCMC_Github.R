library(foreach)
library(parallel)
numcore<-detectCores()
cl <- makeCluster(numcore)

source("BDmcmcbin.R")

nsim<-10

for(i in 1:10){
print(i)
case<-read.table(paste("gent_case",i,".dat", sep=""), sep=",", header=F)
cont<-read.table(paste("gent_cont",i,".dat", sep=""), sep=",", header=F)
case<-t(as.matrix(case[,4:ncol(case)]))
cont<-t(as.matrix(cont[,4:ncol(cont)]))
data.jam<-rbind(cont, case)
YCC<-c(rep(0, nrow(cont)), rep(1, nrow(case)))
prob<-bdmcmcbin(data.jam,YCC,20,100,10)
my.snps=which(prob>0.999)
print(sort(my.snps))
if(i==1){
write(my.snps, "Results_BDMCMC_try.txt", ncol=length(my.snps))}
if(i>1){
write(my.snps, "Results_BDMCMC_try.txt", ncol=length(my.snps), append=T)}
}
