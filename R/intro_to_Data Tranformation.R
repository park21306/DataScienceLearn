library(tidyverse)
library(sqldf)
library(jsonlite)
library(RSQLite)
library(RPostgreSQL)
library(glue)
library(nycflights13)
library(janitor)

## Data Transformation 
## dplyr => grammar of data manipulation

view(mtcars)


## 5 functions

## 1. select() => SELECT SQL
## 2. filter() => WHERE SQL
## 3. arrange => ORDER BY SQL
## 4. mutate() => SELECT .. AS SQL
## 5. summarise()

## select
select(mtcars,1:5)
select(mtcars , mpg , wt , hp , 10:11)
select(mtcars,starts_with("h"))
select(mtcars,ends_with("p"))
select(mtcars,contains("a"))
select(mtcars,carb,everything())

#create new column
mtcars$model <- rownames(mtcars)
rownames(mtcars) <- NULL
select(mtcars,model,everything())
       
## Data Pipeline    %>% (Pipe operator)
m1 <- mtcars %>% 
    select(mpg,hp,wt) %>%
    filter(hp < 100 | wt < 2) %>%
    arrange(desc(hp))


## filter data 
mtcars %>% 
    select(model,mpg,hp,wt,am) %>%
    filter(between(mpg,25,30))


mtcars %>% 
    select(model,cyl) %>%
    filter(cyl %in% c(6,8))


mtcars %>% 
    select(model,cyl) %>%
    filter(cyl %in% c(6,8))


mtcars %>% 
    select(model,mpg,hp,wt,am) %>%
    filter(grepl("^Mazda",model))


## mutate() create new column


m2 <- mtcars %>% 
    select(model,mpg,hp,wt,am) %>%
    mutate(hp_segment = if_else(hp < 100,"low","high"),
           hp_segment2 = case_when(
               hp < 100 ~ 'low' ,
               hp < 200 ~ 'medium',
               TRUE ~ 'high'
           ))
   

## arrange()
mtcars  %>% 
    arrange(desc(mpg)) %>%
    head()

## glimpse data structure
glimpse(mtcars)

## an => 0 = !uto , 1 = Manual
mtcrs <- mtcars %>% 
    mutate(am = if_else(am == 0,"Auto","Manual"),
           vs = if_else(vs == 0,"V-Shaped","Straight"))
    

#count
mtcars %>% 
    count(am)

mtcars %>% 
    count(vs)

m3 <- mtcrs %>% 
    count(am,vs) %>%
    mutate(perpent = n/nrow(mtcrs))


## Read Write CSV Files
write_csv(m3,"summary_mtcars.csv")


m3 <- read_csv("summary_mtcars.csv")
m3 <- as.data.frame(m3)
m3 <- as_tibble(m3)


## Change Data Types
mtcars <-mtcars %>%
    select(model,mpg,vs,am) %>%
    mutate(vs = as.factor(vs),
           am = as.factor(am))


## summarise() + group_by()
mtcars %>%
    group_by(am) %>%
    summarise(
        avg_mpg = mean(mpg),
        sum_mpg = sum(mpg),
        min_mpg = min(mpg),
        max_mpg = max(mpg),
        var_mpg = var(mpg),
        sd_mpg = sd(mpg),
        median_mpg = median(mpg),
        n = n()
    ) -> result


##Join Tables
band_members
band_instruments

inner_join(band_members,
           band_instruments,
           by = "name")


left_join(band_members,
           band_instruments,
           by = "name")


right_join(band_members,
          band_instruments,
          by = "name")

full_join(band_members,
          band_instruments,
          by = "name")


## refactor
band_members %>%
    full_join(band_instruments,
          by = "name") %>%
    filter(name %in% c("John","Paul")) %>%
    mutate(heool = "OK")


flights
glimpse(flights)


flights %>%
    filter(month == 9) %>%
    count(origin,dest)

### carriers most flights
### in March-May 2013
### origin == JFK
df <- flights %>%
    filter(origin == "JFK" & 
           month  %in% c(3,4,5)) %>%
    count(carrier) %>%
    arrange(desc(n)) %>%
    left_join(airlines,by="carrier")

write_csv(df,"requested_data.csv")


## Mock up data
## One to One
student <- data.frame(
    id = 1:5 ,
    name = c("a","b","c","d","e"),
    cid = c(1,2,2,3,2),
    uid = c(1,1,1,2,2)
)


course <- data.frame(
    course_id = 1:3 , 
    course_name = c("Data","R","Python")
)


university <- data.frame(
    uid = 1:2 ,
    uname = c("University of London" , "Chula University")
)

student %>% 
    left_join(course,by = c("cid" = "course_id" )) %>%
    filter(course_name == "R") %>%
    select(name,course_name)


## JOIN more than two tables
student %>% 
    left_join(course,by = c("cid" = "course_id" )) %>%
    left_join(university,by = "uid") %>%
    select(studen_name = name ,
           course_name ,
           university_name = uname) -> de

write_csv(de,"studentProfile.csv")


## Wide -> Long format transformation
Long_Worldphones <- WorldPhones %>%
    as.data.frame() %>%
    rownames_to_column(var  = "Year") %>%
    pivot_longer(N.Amer:Mid.Amer,
                 names_to = "Region" ,
                 values_to = "Sales")


Long_Worldphones %>%
    filter(Region == "Asia")


Long_Worldphones %>%
    group_by(Region) %>%
    summarise(total_sales = sum(Sales))



## long -> wide format
wide_data <- Long_Worldphones %>%
    pivot_wider(names_from = "Region" ,
                values_from = "Sales") 

write_csv(wide_data , "data.csv")


## Connect SQL database
## 1. SQLite
## 2. PostgreSQL server


## step to connect database
## create connection > query > close connection

con <- dbConnect(SQLite(),"chinook.db")

dbListTables(con)
dbListFields(con,"customers")

dbGetQuery(con,"select 
           firstname ,
           lastname ,
           country
           from customers 
           where country 
           in ('France','Austria','Belgium') ")

query01 <- "
    select * from artists
    join albums on artists.artistid = albums.artistid
    join tracks on tracks.albumid = albums.albumid "

tracks <- dbGetQuery(con , query01)

tracks %>%
    select(Composer,Milliseconds,Bytes,UnitPrice) %>%
    filter(Milliseconds > 200000 ,
           grepl("^C",Composer)) %>%
    summarise(
        sum(Bytes),
        sum(UnitPrice)
    )
    
dbDisconnect(con)


## sample data n=10
names(tracks)
    
tracks_clean <- clean_names(tracks)
View(tracks_clean)

set.seed(1) 
tracks_clean %>%
    select(1:2) %>%
    sample_n(10) %>%
    View()


### R connect to PostgreSQL
## username,password,host(server),port,dbname

con2 <- dbConnect(PostgreSQL(),
                  user = "onnpkfse" ,
                  password = "LlechNVyVBhqPlM6sPFDREZyU8jTKsRf",
                  host = "rosie.db.elephantsql.com" , 
                  port = 5432 ,
                  dbname = "onnpkfse")

dbListTables(con2)
course <- data.frame(
    id = 1:5,
    name = c("Data Science" , "Software", "Design" , "R" , "SQL"),
    row.names = FALSE
)

dbWriteTable(con2,"course",course)
dbDisconnect(con2)
