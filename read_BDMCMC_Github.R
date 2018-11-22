count_in_BLK<-function(a,b){
count<-0
for(j in 1:length(a)){
count<-ifelse(a[j] %in% b | (a[j]+1) %in% b | (a[j]-1) %in% b, count+1, count) }
return(count)}

nSim <-10
nTrue <- 7
FDR.SNP<-FDR.BLK<-FDR.BLKEXT<-TDR.SNP<-TDR.BLK<-TDR.BLKEXT<-rep(0, nSim)
block.info.long<-read.csv("block.info.long.csv")
list.SNPsTrue<-read.csv("list.SNPsTrue10rep.csv")
for(i in 1:nSim){
print(i)
SNPsTrue<-as.numeric(as.vector(list.SNPsTrue[i,2:8]))
sort(SNPsTrue)
BLKsTrue<-block.info.long[SNPsTrue,2]
BLKsTrueExt<-c(BLKsTrue,BLKsTrue-1,BLKsTrue+1)
BLKsTrueExt<-BLKsTrueExt[BLKsTrueExt>0 & BLKsTrueExt<85]
sort(BLKsTrue)
system(paste("sed -n '",i," p' Results_BDMCMC_Top10.txt > mysnp.txt", sep=""))
mysnp.file<-read.table("mysnp.txt", header=F, sep=" ")
my.snps<-as.numeric(as.vector(mysnp.file[1,]))
sort(my.snps)
my.blocks=block.info.long[my.snps,2]
my.blocks=unique(my.blocks)
sort(my.blocks)
FDR.SNP[i]<-1-(sum(my.snps %in% SNPsTrue)/length(my.snps))
FDR.BLK[i]<-1-(sum(my.blocks %in% BLKsTrue)/length(my.blocks))
FDR.BLKEXT[i]<-1-(sum(my.blocks %in% BLKsTrueExt)/length(my.blocks))
TDR.SNP[i]<-sum(my.snps %in% SNPsTrue)/nTrue
TDR.BLK[i]<-sum(BLKsTrue %in% my.blocks)/length(BLKsTrue)
TDR.BLKEXT[i]<-count_in_BLK(BLKsTrue, my.blocks)/length(BLKsTrue)
}
print(summary(cbind(FDR.SNP, FDR.BLK, FDR.BLKEXT, TDR.SNP, TDR.BLK, TDR.BLKEXT)))
