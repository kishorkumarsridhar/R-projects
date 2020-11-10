# Setting the working directory

# setwd("\\\\ntdfs\\(W)DataStor\\PerformanceTechnology\\AssetMgmt\\KS_test"")

# installing the necessary packages
install.packages("dplyr")
library(dplyr)

# reading the input files containing the ORIGKEY and IRI values with no NA values for the two comparison years
m <- read.csv('IRI_2015_WoNa.csv', header = T)
n <- read.csv('IRI_2017_WoNa.csv', header = T)

# getting the uniques ORIGKEY values in both years   
muniq <- as.data.frame(unique(m[,1]))
colnames(muniq) <- c("ORIGKEY")
nuniq <- as.data.frame(unique(n[,1]))
colnames(nuniq) <- c("ORIGKEY")

# comparing and matching ORIGKEYS present in both years with no NA values - so that each ORIGKEY has atleast one IRI value in both years in order for the KS test to perform properly
kuniq <- merge(muniq,nuniq, by.x = "ORIGKEY", by.y = "ORIGKEY")

# taking the common ORIGKEYS present in both years as 'ok_list' to use in the 'for' loop
# needs to be a vector instead of a data frame in order to work properly
Ok_list <- as.vector((kuniq$ORIGKEY))


# function to calculate the KS-Test results
testfunc <- function(i){
  
# assigning a name to each KS-plot based on the corresponding ORIGKEY along with the lengends  
  a <- paste("CDF for Origkey = ",Ok_list[i], "\n Blue: 2015", "\n Green: 2017", sep ="")

# using "filter" command to filter out the a particular ORIGKEY from the dataframe     
  k1 <- filter(m, ORIGKEY == Ok_list[[i]])
  k2 <- filter(n, ORIGKEY == Ok_list[[i]])
  
# converting them to vector in order to plot the CDF plots (the ecdf function works only on vectors)  
  s1 <- as.vector(k1)
  s2 <- as.vector(k2)

# finding the average, standard deviation and count for the comparison years after checking that length of s1 and s2 are not not 0 i.e. s1 and s2 have atleast one value in them
  if ((length(s1) != 0) & (length(s2) != 0)){
    
    avg2015 <- c(mean(s1$IRI, na.rm=TRUE))
    avg2017 <- c(mean(s2$IRI, na.rm=TRUE))
    std2015 <- c(sd(s1$IRI, na.rm=TRUE))
    std2017 <- c(sd(s2$IRI, na.rm=TRUE))
    n2015<- c(length(s1$IRI))
    n2017<- c(length(s2$IRI))
    
# calculating the cdf function for the IRI values corresponsing to the ORIGKEY    
    cdf1 <- ecdf(s1$IRI) 
    cdf2 <- ecdf(s2$IRI) 
 
# plotting the cdf plots         
    plot(cdf1, verticals=TRUE, do.points=FALSE, col="blue", xlab = "IRI", ylab = "Cumulative probability", main = a) 
    plot(cdf2, verticals=TRUE, do.points=FALSE, col="green", xlab = "IRI", ylab = "Cumulative probability", main = a, add=TRUE) 
    
# returning the results of the KS-test along with the other values calculated above  
    x <- ks.test(s1$IRI,s2$IRI)
    x1<-x$statistic
    x2<-x$p.value
    return(list(x1, x2, avg2015, avg2017, std2015, std2017, n2015, n2017))
  }
  else {
    break
  }
  
}


# initializing the number of iterations of for loop to the length of the "ok_list" containing the list of ORIGKEYS 
num <-1:length(Ok_list)
# initializing a dataframe in order to store the results 
ks_file<-data.frame()

# running a for loop
for (i in num){
 
# initializing a file to denote the location of the KS-plots in the computer 
  file_name1 = paste("\\ntdfs\\(W)DataStor\\PerformanceTechnology\\AssetMgmt\\KS_test\\cdf_",Ok_list[i],".png", sep ="")
# assigning the filename1 to fn for ease of use in the dataframe  
  fn <- file_name1
# initializing the file name for the CDF plots
  file_name = paste("cdf_",Ok_list[i],".png", sep ="")
# a combination of "png" and "dev.off()" functions are used to copy the plots onto the working directory folder in the computer
  png(file_name)
# assigning the (Ok_list[i]) to mm for ease of use in the dataframe
  mm<-(Ok_list[i])
# accessing the function used to calculate the KS-test
  y<-(testfunc(i))
# storing the results in a dataframe
  b<-data.frame("Origkey"=mm,"statistic"=y[[1]],"pvalue"=y[[2]], "Average 2015"=y[[3]], "Average 2017"=y[[4]],"Std 2015"=y[[5]], "Std 2017"=y[[6]], "N-2015"=y[[7]], "N-2017"=y[[8]], "FN"=fn)
# using the "rbind" function to add values corresponding to each ORIGKEY in consecutive rows in a dataframe
  ks_file<-rbind(ks_file,b)
# a combination of "png" and "dev.off()" functions are used to copy the plots onto the working directory folder in the computer  
  dev.off()
  
} 

#write the final file named "ks_file" with the KS tes results to the folder
write.csv(ks_file, file = "Final_KS_results.csv")

