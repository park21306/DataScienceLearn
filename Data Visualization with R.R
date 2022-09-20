library(tidyverse)


## data pipeline in R
mtcars <- mtcars %>% 
    rownames_to_column() %>%
    rename(model = rowname) %>%
    as_tibble()


## msleep
glimpse(msleep)


## how many row have NA ?
x <- complete.cases(msleep)
sum(x) ;sum(!x)


## filter only NA rows
msleep %>%
    filter(complete.cases(.))

msleep %>%
    filter(is.na(conservation))

msleep %>%
    filter(is.na(sleep_rem))


## Mean Imputation (Replace NA)
## 1. find mean value
## 2. replace NA with mean

avg_sleeprem <- msleep %>%
    summarise(mean(sleep_rem , na.rm = T)) %>%
    pull() %>%
    round(2)

msleep %>%
    mutate(clean_sleep_rem = replace_na(sleep_rem , avg_sleeprem))


## count function
msleep %>%
    count(vore)%>%
    mutate(pct = n/sum(n)) %>%
    arrange(desc(pct))

## Mode Imputation
msleep2 <- msleep %>%
    mutate(clean_vore = replace_na(vore , "herbi")) %>%
    select(name , genus, vore , clean_vore)


## Replace NA with conditional means
avg_sleep_by_vore <- msleep %>%
    group_by(vore) %>%
    summarise(avg_sleeprem = mean(sleep_rem,na.rm = TRUE))


## case when() conditional mean
clean_msleep <- msleep %>%
    select(vore , sleep_rem) %>%
    mutate(clean_sleep_rem = case_when(
        is.na(sleep_rem) & vore == "carni" ~ 2.29 ,
        is.na(sleep_rem) & vore == "herbi" ~ 1.37 ,
        is.na(sleep_rem) & vore == "insecti" ~ 3.52 ,
        is.na(sleep_rem) & vore == "omni" ~ 1.96 ,
        is.na(vore)  ~ 1.88 ,
        TRUE ~ sleep_rem
    ))


msleep %>%
    left_join(avg_sleep_by_vore,by = "vore") %>%
    mutate(clean_sleep_rem = if_else(
        is.na(sleep_rem),avg_sleeprem,sleep_rem
    ))


## working with date
library(lubridate)


## ISO-86011 standard
mydate <- c(
    "2022-06-30",
    "2025-07-15",
    "2024-12-31"
)

ymd(mydate) %>% class()

mydate2 <- c(
    "12-31-2022",
    "11-07-2025",
    "02-25-2022"
)
mdy(mydate2)

dmy(c("25-05-2022",
      "25 May 2022",
      "25-May-2022",
      "25/May/2022"))

ymd_hms(c(
    "2022-05-25 10:1:25" ,
    "2022 May 25th , 10hour 11min 25second"
))

## data frame
df <- data.frame(
    id = 1:5 ,
    date = c("25-05-2022",
             "25 May 2022",
             "25-May-2022",
             "25/May/2022",
             "25 || May || 2022")
)

df %>%
    mutate(date = dmy(date) ,
           day = day(date) ,
           month = month(date) ,
           year = year(date))
