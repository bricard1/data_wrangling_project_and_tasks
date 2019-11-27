## ----lib-----------------------------------------------------------------
library(sqldf)
library(SASxport)
library(mice)
setwd("../Downloads/")
aaa=read.xport("DIQ_I.XPT")
aaa[]=lapply(aaa, as.numeric)


## ----vars----------------------------------------------------------------
onlyvariance=aaa[,which(apply(aaa,2,sd,na.rm=T)!=0)]


## ----columns-------------------------------------------------------------
# DID010 remove borderline refused as missing
onlyvariance$DIQ010[which(onlyvariance$DIQ010>=3)] = NA
onlyvariance$DIQ010=as.factor(onlyvariance$DIQ010)
# DID040: 666 to 1 year
onlyvariance$DID040[which(onlyvariance$DID040==666)] = 1
# DID040 remove over 999
onlyvariance$DID040[which(onlyvariance$DID040>998)] = NA
# DIQ160 remove refused/don't know/missing, code as factor
onlyvariance$DIQ160[which(onlyvariance$DIQ160>=7)] = NA
onlyvariance$DIQ160=as.factor(onlyvariance$DIQ160)
# DIQ170 remove refused/don't know/missing, code as factor
onlyvariance$DIQ170[which(onlyvariance$DIQ170>=7)] = NA
onlyvariance$DIQ170=as.factor(onlyvariance$DIQ170)
# DIQ172 remove refused/don't know/missing, code as factor
onlyvariance$DIQ172[which(onlyvariance$DIQ172>=7)] = NA
onlyvariance$DIQ172=as.factor(onlyvariance$DIQ172)
# DIQ180 remove refused/don't know/missing, code as factor
onlyvariance$DIQ180[which(onlyvariance$DIQ180>=7)] = NA
onlyvariance$DIQ180=as.factor(onlyvariance$DIQ180)
# DIQ050 remove refused/don't know/missing, code as factor
onlyvariance$DIQ050[which(onlyvariance$DIQ050>=7)] = NA
onlyvariance$DIQ050=as.factor(onlyvariance$DIQ050)
#DIQ060 (int) > 666
#DIQ060 remove refused/don't know/missing, 
onlyvariance$DID060[which(onlyvariance$DID060==666)] = 1
onlyvariance$DID060[which(onlyvariance$DID060>=777)] = NA
#onlyvariance$DIQ060=as.factor(onlyvariance$DIQ060)
#DIQ060U (factor) convert to months
onlyvariance$DIQ060U[which(onlyvariance$DIQ060U==2)]=12
#make new column of months of insulin
onlyvariance$monthsinsulin=as.numeric(onlyvariance$DIQ060U)*as.numeric(onlyvariance$DID060)
#remove old columns
onlyvariance <- subset(onlyvariance, select = -DIQ060U)
onlyvariance<- subset(onlyvariance, select = -DID060)
#DIQ070 (bool) > 7
onlyvariance$DIQ070[which(onlyvariance$DIQ070>=7)] = NA
onlyvariance$DIQ070=as.factor(onlyvariance$DIQ070)
# Remove never refused don't know as missing. Debated whether to include this as a factor or int, can see good points for both. Decided to go with factor because I am unsure if the underlying trends can be treated linearly.
onlyvariance$DIQ230[which(onlyvariance$DIQ230>=5)] = NA
onlyvariance$DIQ230=as.factor(onlyvariance$DIQ230)
#DIQ240 removed refused don't know missing
onlyvariance$DIQ240[which(onlyvariance$DIQ240>=7)] = NA
onlyvariance$DIQ240=as.factor(onlyvariance$DIQ240)
#DID250 (int) remove >= 7777
onlyvariance$DID250[which(onlyvariance$DID250>=7777)] = NA
onlyvariance$DID250=as.factor(onlyvariance$DID250)
#DID260 (int) 0,666 -> max(DID260)
onlyvariance$DID260[which(onlyvariance$DID260>=777)] = NA
#DIQ260U (factor) 1/2/3/4 day/week/month/year
#convert to days
onlyvariance$DIQ260U[which(onlyvariance$DIQ260U==2)]=7
onlyvariance$DIQ260U[which(onlyvariance$DIQ260U==3)]=30.5
onlyvariance$DIQ260U[which(onlyvariance$DIQ260U==4)]=365.25
onlyvariance$timeschecksugarday=onlyvariance$DID260*onlyvariance$DIQ260U
#remove columns
onlyvariance <- subset(onlyvariance, select = -DIQ260U)
onlyvariance<- subset(onlyvariance, select = -DID260)
#DIQ275 (bool) >9
onlyvariance$DIQ275[which(onlyvariance$DIQ275>=7)] = NA
onlyvariance$DIQ275=as.factor(onlyvariance$DIQ275)
#DIQ280 (int) >777
onlyvariance$DIQ280[which(onlyvariance$DIQ280>=777)] = NA
#DIQ291 (int) > 6
#we can leave this as int- seems more or less linear (6->7->8->9->10 is original scale)
onlyvariance$DIQ291[which(onlyvariance$DIQ291>=6)] = NA

#Following BP ratings just removed refuesed/don't know/ never heard/never had
#DIQ300S (int) > 7777
onlyvariance$DIQ300S[which(onlyvariance$DIQ300S>=7777)] = NA
#DIQ300D (int) > 7777
onlyvariance$DIQ300D[which(onlyvariance$DIQ300D>=7777)] = NA
#DID310S (int) > 6666
onlyvariance$DID310S[which(onlyvariance$DID310S>=6666)] = NA
#DID310D (int) > 6666
onlyvariance$DID310D[which(onlyvariance$DID310D>=6666)] = NA
#DID320 (int) > 5555
onlyvariance$DID320[which(onlyvariance$DID320>=5555)] = NA
#DID330 (int) > 6666
onlyvariance$DID330[which(onlyvariance$DID330>=6666)] = NA
#DID341 ()
onlyvariance$DID341[which(onlyvariance$DID341>=7777)] = NA
#DID350 (int) (rm 0) (7777)
onlyvariance$DID350[which(onlyvariance$DID350>=7777)] = NA
#DIQ350U (int) (rm 0) (9999)
#convert to days
onlyvariance$DIQ350U[which(onlyvariance$DIQ350U==2)]=7
onlyvariance$DIQ350U[which(onlyvariance$DIQ350U==3)]=30.5
onlyvariance$DIQ350U[which(onlyvariance$DIQ350U==4)]=365.25
onlyvariance$timescheckfeet=onlyvariance$DIQ350U*onlyvariance$DID350
#remove columns
onlyvariance <- subset(onlyvariance, select = -DIQ350U)
onlyvariance<- subset(onlyvariance, select = -DID350)
#DIQ360 keep as factor
onlyvariance$DIQ360[which(onlyvariance$DIQ360>=6)] = NA
onlyvariance$DIQ360=as.factor(onlyvariance$DIQ360)
#DIQ080 
onlyvariance$DIQ080[which(onlyvariance$DIQ080>=7)] = NA
onlyvariance$DIQ080=as.factor(onlyvariance$DIQ080)


## ----sql-----------------------------------------------------------------
#use sql to check a few counts
#missing values should equal the number of other/nothing
library(sqldf)
#DIQ275 should have 641/156 
sqldf("select count(DIQ275) from onlyvariance group by DIQ275")
#DIQ050 should be 256 yes and 9316 no
sqldf("select count(DIQ050) from onlyvariance group by DIQ050")
#DIQ050 should be 2836 yes and 2167 no
sqldf("select count(DIQ180) from onlyvariance group by DIQ180")


## ----variance------------------------------------------------------------
imputed=mice(onlyvariance)
data_all <- complete(imputed,"long")


## ----head----------------------------------------------------------------
head(data_all, n=50)

