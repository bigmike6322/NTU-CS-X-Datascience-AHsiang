### hw_1_question


########################################################### Task 1

# 查看內建資料集: 鳶尾花(iris)資料集
iris

# 使用dim(), 回傳iris的列數與欄數
dim(iris)

# 使用head() 回傳iris的前六列

head(iris)
# 使用tail() 回傳iris的後六列
tail(iris)

# 使用str() 
str(iris)

# 使用summary() 查看iris敘述性統計、類別型資料概述。
summary(iris)

########################################################### Task 2

# 使用for loop 印出九九乘法表
# Ex: (1x1=1 1x2=2...1x9=9 ~ 9x1=9 9x2=18... 9x9=81)
for(x in c(1:9)){
  for(y in c(1:9)){
    print(paste(x,"x",y,"=",x*y))
  }
}

########################################################### Task 3

# 使用sample(), 產出10個介於10~100的整數，並存在變數 nums
nums<- sample(10:100,10,replace = FALSE, prob = NULL)
nums
# 查看nums
print(nums)
# 1.使用for loop 以及 if-else，印出大於50的偶數，並提示("偶數且大於50": 數字value)
# 2.特別規則：若數字為66，則提示("太66666666666了")並中止迴圈。

for (num in nums) {
    if ((num %% 2 == 0) && (num > 50)) {
      print(nums)
      print(paste("偶數且大於50：", num))
    }
    if (num == 66) {
      print("太66666666666了")
      break
    } 
}


for(x in c(1:10)){
  if(nums[x]>50 && nums[x]%%2==0){
    result1 <-paste("偶數且大於50",":",nums[x])
    print(result1)
  }
  if(nums[x]==66){
    print("太66666666666了")
    break
  }
}




repeat{
  x<-sample(nums,10,replace = FALSE, prob = NULL)
      print(x)
    C <- x>50 &&x%%2==0
    D <- x ==66
  if(C){    
    print("偶數且大於50")
    }
  if(D){    
    break
    print("太66666666666了")
  }
}




#repeat{
 # nums <-10:100
  #x <- sample(nums,10,replace = FALSE, prob = NULL)
#  x
#  if(x>50 && x%%2==0)
#  {
#      print("偶數且大於50")
#  }
#  if(x==66)
#  {
#    break
#    print("太66666666666了")
#  }
#  print(x)  
# }

########################################################### Task 4

# 請寫一段程式碼，能判斷輸入之西元年分 year 是否為閏年
x<-1601
  ifelse(x%%4 ==0 && x%%100 !=0 ||x%%400==0,"是閏年","不是閏年" )

########################################################### Task 5

# 猜數字遊戲
# 1. 請寫一個由電腦隨機產生不同數字的四位數(1A2B遊戲)
# 2. 玩家可重覆猜電腦所產生的數字，並提示猜測的結果(EX:1A2B)
# 3. 一旦猜對，系統可自動計算玩家猜測的次數

#先產生一組電腦的答案
answer<-sample(0:9,4,replace = FALSE,prob = NULL)
#玩家輸入一組數字
input<-
#最外圍要用repeat函數
repeat{
  scan(input,nmax=4)
  #用for loop、[]去檢查玩家的數字
  
  #如果數字跟位置都一樣，顯示為A
  #如果有這個數字，但位置不對，顯示為B
  #如果兩組答案一致（猜對），就break
  
}
  





