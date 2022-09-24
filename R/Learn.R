friend <- c("Park","test","run","fail")
ages <-c(23,15,89,6)
locations <-c("Bangkok","London","Tokyo","New York")
movie_love <-c(TRUE,TRUE,TRUE,FALSE)
##usevector
dfv1<- data.frame(friend,ages,locations,movie_love)
data.frame(dfv1)
View(dfv1)
##uselist
dfv2<-list(friend = friend,age = ages,local = locations,movie = movie_love)
data.frame(dfv2)
View(dfv2)
my_sum <- function(num1,num2=10){
  num1+num2
}
##Call function in Library
library(glue)
my_name <- "Park"
my_age <- 24
glue("Hello my name is {my_name} . This year I'm {my_age} years old.")
##DataFrame
df <- data.frame(id = 1:4,friend,ages,movie_love)
View(df)
## write csv file
write.csv(df,"friends.csv",row.names = FALSE)
##control flow
# 1.if
check_grade <-function(score){
  if(score >= 90){
    print("Passed")
  }
  else{
    print("Failed")
  }
}
check_grade2 <-function(score){
  ifelse(score >= 80,"Passed","Failed")
}
check_grade3 <-function(score){
  if(score >=80){
    print("A")
  }
  else if(score >=70){
    print("B")
  }
  else if(score >= 60){
    print("C")
  }
  else if(score >= 50){
    print("D")
  }
  else{
    print("Failed")
  }
}
  
#2.for loop
numbers <-c(10,15,20,50)
for(num in numbers){
  print(num *2)
}

numbers * 2 # คือการคูณในเวกเตอร์ได้เลย

##-----------------------------------
paste("hello!",friend)


##3. while
x <- 0
while (x< 5) {
  print ("Hello !")
  x <- x+1  
}

##check username ,password

check_in <- function(){
  user_input <- readline("what is your username : ")
  user_pw <- readline("what is your password : ")
  
  sys_un <-" park"
  sys_pw <- "21306"
  
  if (user_input == sys_un & user_pw == sys_pw){
    print("Log in successfully")
  }
  else{
    print("Please check your username & password")
  }
}

##data transformation / data viz 101

#dplyr
select(mtcars,1:3,5,11)

#pipe operator
mtcars %>%
  #step 1 select column
  select(mile_per_gallon = mpg,auto_manual = am,hourse_power = hp,weight = wt)
  #select 2 filter row
  filter(mile_per_gallon <= 15)

