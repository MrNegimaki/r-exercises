library(dplyr)
library(tidyr)
titanic <- as.data.frame(read.csv("C:/Users/Michael/Desktop/titanic_original.csv", sep=","))
titanic$embarked[titanic$embarked==""] <- "S"
titanic$age[is.na(titanic$age)] <- mean(titanic$age, na.rm = TRUE)
titanic$boat[titanic$boat==""] <- NA
titanic$has_cabin_number <- titanic$cabin
titanic$has_cabin_number[titanic$has_cabin_number==""] <- 0
titanic$has_cabin_number <- ifelse(is.na(titanic$has_cabin_number),0,1)
write.csv(titanic, "C:/Users/Michael/Desktop/titanic_clean.csv", row.names=FALSE)