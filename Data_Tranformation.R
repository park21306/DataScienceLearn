## Data Transformation 

##install.packages("tidyverse",dependencies = TRUE)
library(tidyverse)
#read data file
friends <- read_csv("friends.csv")

df1 <- read_delim("text_file_01.txt", delim = ";")

df2 <- read_delim("text_file_02.txt", delim = "\t")


##tibble == enchanced dataframe
mtcars <- tibble(mtcars)

## dplyr - data transformation
## 1.select()
## 2.filter()
## 3.mutate()
## 4.arrange()
## 5.summarise()


##select colum
select(mtcars, mpg, hp , wt)
select(mtcars, 1,2,4,6)
select(mtcars,1:3,8:10)
