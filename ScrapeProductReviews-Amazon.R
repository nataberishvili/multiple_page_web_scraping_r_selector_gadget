library(pander)
library(rvest)
library(stringr)
library(dplyr)
library(lubridate)
library(tidytext)
library(qdap)
library(textdata)
library(tidyr)



#Scrape reviews from multiple pages (150 page specified) for the product.
#Revlon Colorsilk Beautiful Color, Permanent Hair Dye with Keratin,
reviewdate <- lapply(paste0("https://www.amazon.com/Revlon-ColorSilk-Tinte-paquete-Auburn/product-reviews/B07DGCLQD5/ref=cm_cr_arp_d_viewopt_kywd?ie=UTF8&reviewerType=all_reviews&sortBy=recent&pageNumber=", 1:150),
                     function(url){
                       url %>% read_html() %>% 
                         
                         html_nodes(".review-date") %>% 
                         html_text()%>%
                         str_trim()
                       
                     })

Sys.sleep(7)
profilename <- lapply(paste0("https://www.amazon.com/Revlon-ColorSilk-Tinte-paquete-Auburn/product-reviews/B07DGCLQD5/ref=cm_cr_arp_d_viewopt_kywd?ie=UTF8&reviewerType=all_reviews&sortBy=recent&pageNumber=", 1:150),
                      function(url){
                        url %>% read_html() %>% 
                          html_nodes(".a-profile-name") %>% 
                          html_text()%>%
                          str_trim()
                        
                      })

Sys.sleep(5)
iconalt <- lapply(paste0("https://www.amazon.com/Revlon-ColorSilk-Tinte-paquete-Auburn/product-reviews/B07DGCLQD5/ref=cm_cr_arp_d_viewopt_kywd?ie=UTF8&reviewerType=all_reviews&sortBy=recent&pageNumber=", 1:150),
                  function(url){
                    url %>% read_html() %>% 
                      html_nodes(".review-rating") %>% 
                      html_text()%>%
                      str_trim()
                  })

Sys.sleep(4)
reviewdata <- lapply(paste0("https://www.amazon.com/Revlon-ColorSilk-Tinte-paquete-Auburn/product-reviews/B07DGCLQD5/ref=cm_cr_arp_d_viewopt_kywd?ie=UTF8&reviewerType=all_reviews&sortBy=recent&pageNumber=", 1:150),
                     function(url){
                       url %>% read_html() %>% 
                         html_nodes(".review-text-content") %>% 
                         html_text() %>%
                         str_trim()
                     })

#unlist
reviewdata <- unlist(reviewdata)
reviewdate <- unlist(reviewdate)
iconalt <- unlist(iconalt)
profilename <- unlist(profilename)
#create a dataframe
allreviews2 <- as.data.frame(cbind(reviewdata, reviewdate, iconalt, profilename))
#assign the product name to dataframe
allreviews2$product <- c("Revlon Colorsilk - Permanent Hair die")

#rite into csv file
write.csv(allreviews2, file = "revloncolorsilk2.csv", row.names = FALSE)
