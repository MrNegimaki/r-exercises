library(dplyr)
library(tidyr)
refine <- as.data.frame(read.csv("C:/Users/Michael/Desktop/refine_original.csv", sep=",")) %>% arrange(company)
refine[1:7,1] <- "akzo"
refine[8:16,1] <- "philips"
refine[17:20,1] <- "unilever"
refine[21:25,1] <- "van houten"
refine <- separate(refine, Product.code...number, c("product_code","product_number"), sep = "-")
refineq <- gsub("p","Smartphone",refine[,2]) 
refine$product_code <- refineq
refineq <- gsub("v","TV",refine[,2]) 
refine$product_code <- refineq
refineq <- gsub("x","Laptop",refine[,2]) 
refine$product_code <- refineq
refineq <- gsub("q","Tablet",refine[,2]) 
refine$product_code <- refineq
refine <- unite_(refine,"address", c("address","city","country"), sep = " ")
refine <- spread(refine, company, company)
refine <- spread(refine, product_code, product_code)
names(refine) <- c("product_number","address","name","company_akzo","company_philips",
                   "company_unilever","company_van_houton","product_laptop","product_smartphone",
                   "product_tablet","product_tv")
refine[,4:11] <- is.na(refine[,4:11])
refine[,4:11] <- as.numeric(!refine[,4:11])
write.csv(refine, "C:/Users/Michael/Desktop/refine_clean.csv", row.names=FALSE)