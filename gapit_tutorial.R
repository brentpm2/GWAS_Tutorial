source("http://zzlab.net/GAPIT/GAPIT.library.R")
source("http://zzlab.net/GAPIT/gapit_functions.txt")

my_packages <- library()$results[,1]
"GAPIT3" %in% my_packages

setwd("/path/to/directory/")

phenotypes <- read.table("gwas_training.phenotypes.txt",sep = "\t",head=TRUE)
genotypes <- read.table("palmer_dataset.hmp.txt",head=F)

#convert from hapmap to numeric

myGAPIT <- GAPIT(G=genotypes,output.numerical=T)
myGD <- myGAPIT$GD
myGM <- myGAPIT$GM

dir.create("model_selection")

setwd("./model_selection")

#model selection and minor allele frequency
my_gapit <- GAPIT(Y=phenotypes[,c(1,8)],GD=myGD,GM=myGM,PCA.total=3,model=c("GLM","MLM","FarmCPU","Blink"))

#heritability

dir.create("gapit_heritability")
setwd("../gapit_heritability")

my_gapit <- GAPIT(Y=phenotypes[,c(1,5,6,7)],GD=myGD,GM = myGM,PCA.total=3,model=c("MLM"))

#phenotyping


dir.create("gapit_heritability")
setwd("../gapit_heritability")
my_gapit <- GAPIT(Y=phenotypes[,c(1,2,3,4)],GD=myGD,GM = myGM,PCA.total=3,model=c("MLM"))