#魔球
#目標：找到三名替代球員
#三項重要指標，打擊率、上壘率、長打率。
#打擊率(BA)=安打數（H）/打數（AB）
#上壘率(OBP)=（安打H + 保送BB + 觸身球HBP）/（打數AB + 保送BB + 觸身球HBP + 高飛犧牲打SF）
#長打率(SLG)=((一壘安打1B)+(2*二壘安打2B)+(3*三壘安打3B)+(4*全壘打HR))/打數(AB)

batting <- read.csv('/Users/bigmike6322/Documents/GitHub/NTU-CS-X-RProject-AHsiang/week_3/ggplot練習/baseballdatabank-master/core/Batting.csv')
str(batting)

#BA的部分，用head函數來測試跑步跑得出來
batting$BA <- batting$H / batting$AB
head(batting$BA)

#OBP的部分
batting$OBP <- (batting$H + batting$BB + batting$HBP)/(batting$AB + batting$BB + batting$HBP + batting$SF)
head(batting$OBP)

#SLG的部分
batting$X1B <-batting$H - batting$X2B - batting$X3B - batting$HR
batting$SLG <-((batting$X1B)+(2*batting$X2B)+(3*batting$X3B)+(4*batting$HR))/batting$AB
head(batting$SLG)

#球員薪資
money <- read.csv('/Users/bigmike6322/Downloads/baseballdatabank-2017.1/core/Salaries.csv')
summary(money)

#發現salary的資料只有從1985年開始計算，所以batting的資料也只有1985年之後的才有意義，故subset一下
batting <- subset(batting,yearID >= 1985)


#依照隊員姓名以及yearID將兩個表單合併
combine_money_batting <- merge(batting,money,by=c('playerID','yearID'))
summary(combine_money_batting)

#先找出三位離開的球員的資料
lost_player <-subset(combine_money_batting,playerID %in% c('giambja01','damonjo01','saenzol01'))
lost_player

#限定只要這三位球員2001年的資料
lost_player_2001 <- subset(lost_player, yearID==2001)
#限定只要2001年
lost_player_2001 <- lost_player_2001[,c('playerID','H','X2B','X3B','HR','OBP','SLG','BA','AB','salary')]
head(lost_player_2001)

#接著再來找替補球員
#限制是預算不能超過一千五百萬、打數需要大於或等於失去的三個球員、平均的上壘率要等於或大於失去的三個球員。
#filter函數是屬於dplyr套件包的，也可以用subset，只是subset函數適合用在比較小筆資料
#依照失去三位球員的平均打數(BA)1469/3=489、平均上壘率(OBP)=036387687、

#playerID   H X2B X3B HR       OBP       SLG        BA  AB
#5738  damonjo01 165  34   4  9 0.3235294 0.3633540 0.2562112 644
#8816  giambja01 178  47   2 38 0.4769001 0.6596154 0.3423077 520
#22437 saenzol01  67  21   1  9 0.2911765 0.3836066 0.2196721 305

substitute_player <-subset(combine_money_batting, yearID == 2001)
substitute_player

library(ggplot2)
pl1 <- ggplot(substitute_player,mapping=aes(x=OBP,y=salary)) + geom_point()
pl1

substitute_player<- subset(substitute_player,OBP>=0.3638 & salary<5000000)
substitute_player<- subset(substitute_player,AB>=500)
substitute_player

#依照上壘率由大至小排列前十個   ->desc（遞減）
library(plyr)
possible <- head(arrange(substitute_player,desc(OBP)),10)   #使用head函數來找出前十名即可
possible <-possible[,c('playerID','OBP','BA','AB','salary')]
possible