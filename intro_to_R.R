# intro to R
1+1
2*2
5-3
10-6
print("hello world")

# create variables
income <- 45000
expense <- 26000
saving <- income - expense
print(saving)

# remove variable
rm(expense)
rm(saving)

# create your own function
greeting <- function() {
    print("hello world")
}

my_sum <- function(a,b) {
    a + b
}

my_sum2 <- function(a,b) a+b
greeting2 <- function() print("hello world")

# control flow
# if, for, while
grading <- function(score) {
    if (score >= 90) {
        return("A")
    } else if (score >= 80) {
        return("B")
    } else if (score >= 70) {
        return("C")
    } else {
        return("D")
    }
}

# for loop
for (i in 1:10) {
     print("hello world!")
}

# five student scores ={95,50,88,72,75}
scores <- c(95, 50, 88, 72, 75) 

for (score in scores) {
    print(grading(score))
}

# while loop
count <- 0

while (count < 10) {
    print("hello")
}

# guess animal name

guess_animal_game <- function(animal) {
    while (TRUE) {
        user_input <- tolower(readline("Guess animal: "))
        if (user_input == animal) {
          print("Congratulations! your guess is correct!")
          break
        } else {
          print("Your guess is incorrect. Please try again.")
        }
    }  
}

# username password login application

login_fn <- function() {
    username <- "toyeiei"
    password <- "1234"
    count <- 0 
    
    # get input from user
    while (count < 3) {
        un_input <- readline("Username: ")
        pw_input <- readline("Password: ")
        
        # check username, password
        if (username == un_input & password == pw_input) {
            print("Thank you! you have successfully login.")
            break
        } else {
            print("Sorry, please try again.")
            count <- count + 1
        }
    }
}

### HOMEWORK assignment - 01
### BREAK 10 minutes - see you at 10.40am na kub :)


## Data Types
## numeric, character, logical, factor

friends <- c("toy", "ink", "aan", "top", "wan")
ages <- c(33, 30, 34, 28, 25)
movie_lover <- c(TRUE, TRUE, FALSE, T, F)

# nominal factor
jobs <- c("data", "data", "digital", "digital", "phd")
jobs <- factor(jobs)
class(jobs)

# ordinal factor
handsome_degree <- c("low", "medium", 
                     "high", "high", "high")
handsome_degree <- factor(handsome_degree,
                          levels = c("low", "medium", "high"),
                          ordered = TRUE)

## create dataframe
length(friends)
df <- data.frame(friend_id = 1:5,
                 friends,
                 ages,
                 movie_lover,
                 jobs,
                 handsome_degree)

## Write CSV file
write.csv(df, "friends.csv",
          row.names = FALSE)

## Read CSV file
friends <- read.csv("friends.csv")

## Read CSV file from internet
url <- "https://gist.githubusercontent.com/seankross/a412dfbd88b3db70b74b/raw/5f23f993cd87c283ce766e7ac6b329ee7cc2e1d1/mtcars.csv"

mtcars_df <- read.csv(url)

View(mtcars_df)

john <- list(
  
)












