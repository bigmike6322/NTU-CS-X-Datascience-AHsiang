#week_2 Task
#建立一命名為week_2(or task_2, hw_2)的資料夾。
#完成一支網站爬蟲上傳至資料夾中，繳交三種類型檔案(.R, .Rmd, .html)。


#練習一-跟著網友教學爬爬爬
#rm(list = ls())
library(jsonlite)
url <-"http://ecshweb.pchome.com.tw/search/v3.3/all/results?q=macbook%20pro&page=1&sort=rnk/dc"
macbook_data <-fromJSON(url)
page_nums <-1:macbook_data$totalPage

new_urls<- paste(
  "http://ecshweb.pchome.com.tw/search/v3.3/all/results?q=macbook%20pro&page=",page_nums,"&sort=rnk/dc",sep = "")
product_names <- c()
product_descriptions <-c()
product_prices <-c()

for( i in 1:5){
  single_page_url<-fromJSON(new_urls[i])
  product_names<-c(product_names,single_page_url$prods$name)
  product_descriptions <-c(product_descriptions,single_page_url$prods$describe)
  product_prices<-c(product_prices,single_page_url$prods$price)
  Sys.sleep(sample(2:5,size=1))
}
macbook_dataframe <-data.frame(product_names,product_descriptions,product_prices)
head(macbook_dataframe)



#練習二- 舉一反一自己爬爬pchome皇家貓飼料
library(jsonlite)

url<-"http://ecshweb.pchome.com.tw/search/v3.3/all/results?q=%E7%9A%87%E5%AE%B6%E8%B2%93%E9%A3%BC%E6%96%99&page=1&sort=rnk/dc"
cat_food <- fromJSON(url)
page_nums <-1:cat_food$totalPage

cat_url<-paste("http://ecshweb.pchome.com.tw/search/v3.3/all/results?q=%E7%9A%87%E5%AE%B6%E8%B2%93%E9%A3%BC%E6%96%99&page=",page_nums,"&sort=rnk/dc",sep="")
cat_product_names <-c()
cat_product_descriptions <-c()
cat_product_prices <-c()

for(i in 1:10){
  single_page_url <- fromJSON(cat_url[i])
  cat_product_names <- c(cat_product_names,single_page_url$prods$name)
  cat_product_descriptions <- c(cat_product_descriptions,single_page_url$prods$describe)
  cat_product_prices <- c(cat_product_prices,single_page_url$prods$originPrice)
  Sys.sleep(sample(2:5,size=1))  #加這行是為了避免過於密集訪問，造成該網站伺服器負擔而被封鎖
  }

cat_food_dataframe <- data.frame(cat_product_names,cat_product_descriptions,cat_product_prices)
tail(cat_food_dataframe)


練習三 - 爬個新聞好ㄌ
library(rvest)
url <-"http://www.chinatimes.com/realtimenews/260410"
res<-read_html(url)


res.title <- res %>% html_nodes("h2 a") %>% html_text()

res.link <- res %>% html_nodes("h2 a") %>% html_attr("href")

news.df <- data.frame(res.title,res.link)
colnames(news.df) <-c("title","link")
#這一頁其實有十三個新聞，但爬出來只有十個，原因是其中三個是他偷偷塞給你的廣告！！！


練習四 - 爬個TVBS好ㄌ
#想抓link抓不太到QQ
#css selector是輔助，照理說你想要找的在element或其他地方也可以找到，只是他很方便告訴你的簡碼是啥～
#似乎有需求要了解Xpath是什麼了～～～～
#我好像有碰到漏抓的問題，可能沒有scroll到的沒抓到

library(rvest)
url <-"https://news.tvbs.com.tw/"
res <-read_html(url)

res.title <-res %>% html_nodes("h2.txt")%>% html_text()  
res.title

#news.df<- data.frame(res.title,res.link)
#colnames(news.df) <-c("title","link")


# html_nodes("div ul li a")  =   html_nodes("div") %>% html_nodes("ul") %>% html_nodes("li") %>% html_nodes("a") ??
#res.title <- res %>% html_nodes("div") %>% html_nodes("ul") %>% html_nodes("li") %>% html_nodes("a") %>% html_text()  
#res.link <- res %>% html_nodes("div h2") %>% html_node("a") %>% html_attr("href")

練習五 - 抓Dcard有什麼廢文
library(jsonlite)
Url <-"https://www.dcard.tw/_api/forums/whysoserious/posts?popular=true&before=228522173"
res <-fromJSON(url)
res

raw.title <- res %>% html_node("topic")
raw.title


#是不是不給爬QQQ
#請問一下QQ我剛剛想要爬Dcrad，原本有找到我要爬的東西，但過沒多久重新整理的時候就發現不見惹，重新輸入我剛爬到的url卻發現一片空白惹，是我剛剛眼睛業障重，還是不給爬Q


練習六 - 五九一出租網yo該換房子ㄌ
#不知道有沒有可能之後可以做一個可以動態輸入資料一直爬的那種？
library(jsonlite)

product_names <- c()
product_prices <-c()

for(i in 1:5){
  url<- paste("https://rent.591.com.tw/home/search/rsList?is_new_list=1&type=1&kind=1&searchtype=3&region=1&school=191&rentprice=7&keywords=%E5%A4%A7%E5%AE%89%E5%8D%80&firstRow=",
              30(i-1),"&totalRows=118",sep = "")
  rent_data <- fromJSON(url)
  product_names<-c(product_names,url$h3$a)
  product_prices<-c(product_prices,url$price)
  Sys.sleep(sample(2:5,size=1))
}


rent_dataframe <-data.frame(product_names,product_prices)
head(rent_dataframe)



練習七 - ptt爬文
url<-'https://www.ptt.cc/bbs/MobileComm/index3641.html'
ptt.title <- read_html(url) %>%
  html_nodes(".title a") %>%
  html_text(trim = T)
ptt.title
#是不是只要有最接近資料的那行code就可以爬到了？
# html_nodes(".title a") =  html_nodes(".title ") =   html_node("body") %>%html_nodes(".title") %>%  ??


