#intro to R programming
1+1
2*2
5-3
1-6
print("hello world")

income <- 45000
expense <-26000
saving <- income-expense
print(saving)


#remove variable
rm(expense)
rm(saving)


#create your own function
greeting <-  function(){
    print("hello world")
}

greeting2 <- function() print("hello world")

my_sum <- function(a,b){
    return(a+b)
}

my_sum2 <- function(a,b) a+b

#control flow
# if ,for,while

grading <- function(x){
    if (x >= 90){
        return("A")
    } else if (x >= 80){
        return("B")
    } else if(x >= 70){
        return("C")
    } else{
        return("D")
    }
}


score <- 85 #100
if (score >= 90){
    print("A")
} else if (score >= 80){
    print("B")
} else if(score >= 70){
    print("C")
} else{
    print("D")
}


#for loop
for(i  in 1:10){
    print("hello world")
}

#five student scores
scores <- c(95,50,88,72,75)

for(a  in scores){
    print(grading(a))
}


#while loop
count <- 0
while(count < 10){
    print("hello")
    count <- count +1 
}

#guess animal name


guess_animal_game <- function(animal){
    while(TRUE){
        user_input <-tolower( readline("Guess animal : "))
        if(user_input == animal){
            print("Congratulations! you guess is correct!")
            break
        } else{
            print("you guess is incorrect. Please try again.")
        }
    }
}

#username password login application

login_fn <- function(){
    # a user can try 3 times attempt to login
    username <- "park21306"
    password <- "1234"
    i <- 0
    #get input from user
    while (i < 3) {
        un_input <- readline("Username: ")
        pw_input <- readline("Password")
        #check username,password
        if(username == un_input & password == pw_input){
            print("Thank you! you have successfully login.")
            break
        } else {
            print("Sorry, please try again.")
            i <- i+1
        }
    }
   
}


##Data Types
## numeric,character,logical,factor

friend <- c("A","b","C","d","E")
age <- c(33,30,34,28,25)
movie_lover <- c(TRUE,TRUE,FALSE,T,F)


# nominal factor
jobs <- c("data","data","digital","digital","phd")
jobs <- factor(jobs)
class(jobs)


# ordinal factor
handsome_degree <- c("low","medium","high","high","high")
handsome_degree <- factor(handsome_degree,levels = c("low","medium","high"),ordered = TRUE)


## create dataframe
df <- data.frame(friend_id = 1:5,friend,age,movie_lover,jobs,handsome_degree)


# Write CSV file
write.csv(df,"friend.csv",row.names = FALSE)

## Read CSV file
df <- read.csv("friend.csv")


## Read CSV file form internet
url <- "https://gist.githubusercontent.com/seankross/a412dfbd88b3db70b74b/raw/5f23f993cd87c283ce766e7ac6b329ee7cc2e1d1/mtcars.csv"

mtcars_df <- read.csv(url)

View(mtcars_df)
