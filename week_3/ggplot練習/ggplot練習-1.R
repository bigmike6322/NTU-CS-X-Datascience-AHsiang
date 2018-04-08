library(ggplot2)
library(ggthemes)
library(data.table)
#df <- read.csv("/Users/bigmike6322/Documents/GitHub/NTU-CS-X-RProject-AHsiang/week_3/ggplot練習/Economist_Assignment_Data.csv")
#str(df)

df <- fread('/Users/bigmike6322/Documents/GitHub/NTU-CS-X-RProject-AHsiang/week_3/ggplot練習/Economist_Assignment_Data.csv', drop=1)   #drop會把你指定的該數字整欄隱藏住
str(df)

#The points are colored by region. 也可以換不同的category
pl <- ggplot(df, aes(x = CPI, y = HDI , color=Region)) + geom_point(shape=1, size=0.5)
pl

#geom_smooth中的參數：method可以用不同的方式來線性回歸data，預設值是"loess"，但也可以用別的，比方說lm, glm, gam, loess, rlm，lm->一元一次"、method='lm', formula=y~log(x)->"lm"+自己寫的一元二次的方程式、se= TRUE/FALSE對應到灰色的誤差區間打開/關掉，fill可以調整灰色區間的顏色，size/alpha/color調整線的粗細/透明度/顏色，
pl2 <-pl +geom_smooth(aes(group=1),method='lm', formula=y~log(x),se=FALSE)     #group選1234對應到Region的Americas/Asia Pacific/...etc; group1=group"Amercias"
#pl2

#可以再根據pl2用goem_text做出的線性回歸去標記出每個點是啥
pl3 <- pl2+ geom_text(aes(label=Country))
#pl3

#可以用pointsToLabels特別抓出需要的country
pointsToLabel <-c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                  "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                  "India", "Italy", "China", "South Africa", "Spane","Norway","Singapore")
pl3 <-pl2 + geom_text(aes(label = Country),color ="blue", data = subset(df,Country %in% pointsToLabel),check_overlap =TRUE ) #check_overlap，在小圖中如果有重複就不會出現要出現就是FALSE，或是開Zoom把圖放大才有

#可以幫指標圖的部分去個背（加主題）
pl4 <- pl3 + theme_bw() #白色背景、theme_grey()是灰色背景

#加上圖表的Title跟整張圖的XY軸數值上限
pl5 <-pl4+ scale_x_continuous(limits = c(1,11),breaks = 1:10)+ scale_y_continuous(limits = c(0.25,1)) #從0.25開始圖比較漂亮
#pl5
pl6 <-pl5 + labs(title="Corruption and Human Development")
#pl6

#add theme ，其中一種theme_economist_white()  
pl_final <-pl6 + theme_economist_white()     
pl_final