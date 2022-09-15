head(mtcars)

#1. how many variables?
#2. data type of each variable

ggplot(data = mtcars,aes(mpg))+
  geom_histogram(bins = 10)

ggplot(data = mtcars,aes(mpg))+
  geom_density()

ggplot(data = mtcars,aes(mpg))+
  geom_boxplot()

## put first layer into a variable
p <- ggplot(data = mtcars,aes(mpg))
p + geom_histogram(bins = 10)
p + geom_density()
p + geom_boxplot()
p + geom_bar()

## two variables numeric -> scatter plot
p1 <- ggplot(mtcars,aes(hp,mpg))+
  geom_point()+
  geom_smooth(se = TRUE,col = "salmon")+
  geom_rug()

p1+theme_minimal()+
  labs(title = "My First ggplot chart",
      x = "Horse Power",
      y = "Miles per Gallon")
