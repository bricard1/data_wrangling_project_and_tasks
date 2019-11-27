library("RODBC")
library(dplyr)
require(tidyverse)
library(sqldf)
myconn<-odbcConnect("***","***","***")
demo<-sqlQuery(myconn,"select * from Demographics")
texts<-sqlQuery(myconn,"select * from TextMessages")
cond<-sqlQuery(myconn,"select * from Conditions")

colnames(demo)[1]="ID"
colnames(texts)[1]="ID"
colnames(cond)[1]="ID"
democond=merge(demo,cond, by="ID",all=T)
all3=merge(democond,texts,by="ID",all=T)
all3$TextSentDate=as.character(all3$TextSentDate)
all3$TextSentDate=strptime(all3$TextSentDate, format = "%m/%d/%y")
all3$TextSentDate=as.POSIXct(all3$TextSentDate)
aa=aggregate(TextSentDate ~ ID, all3, function(x) min(x))

all3 %>% group_by(ID) %>% filter(TextSentDate == max(TextSentDate)) %>% distinct(ID,.keep_all=T)

                                                                                 
