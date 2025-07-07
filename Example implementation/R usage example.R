#Run this section if you do not have SMBanalysis installed
#library(devtools) # Make sure that the devtools library is loaded
#install_github("sbernierjhu/SMBAnalysis")

#load needed packages
library(tidyverse)
library(SMBanalysis)

#The cubic deviation metric can be calculated for a list of numbers as follows:
CubicDeviationMetric(1,2,3,60,120,72,decimals = 4)

#You can also apply it to a dataframe by inputting column references for df$a, df$b, etc.
#However, we recommend using mutate() from the dplyr package instead, as follows:
df <- read.delim("example data.csv",header = TRUE,sep = ",",stringsAsFactors = TRUE)
df <- df %>% mutate(CDM=CubicDeviationMetric(a,b,c,alpha,beta,gamma,decimals=3))
view(df)
