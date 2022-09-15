# basic plot (base R)
hist(mtcars$mpg)
# Analyzing horse power
# Histogram - One Qualitative variable
hist(mtcars$hp)
mean(mtcars$hp)
median(mtcars$hp)

str(mtcars)
mtcars$am <- factor(mtcars$am,levels = c(0,1),labels = c("Auto", "Manual"))

# Bar Plot  - One Qualitative variable
barplot(table(mtcars$am))

# Box Plot 
boxplot(mtcars$hp)
fivenum(mtcars$hp)

min(mtcars$hp)
quantile(mtcars$hp,probs = c(.25,.5,.75))
max(mtcars$hp)

# Whisker Calculation
Q3 <- quantile(mtcars$hp,probs = .75)
Q1 <- quantile(mtcars$hp,probs = .25)
IQR_hp <- Q3-Q1

Q3 + 1.5 * IQR_hp
Q1 - 1.5 * IQR_hp

boxplot.stats(mtcars$hp,coef = 1.5)

# Filter out outliers
mtcars_no_out <- mtcars %>% filter(hp < 335)

boxplot(mtcars_no_out$hp)

# Boxplot 2 variables
## Qualitative x Qualitative
data(mtcars)
mtcars$am <- factor(mtcars$am,levels = c(0,1),labels = c("Auto", "Manual"))
boxplot(mpg ~ am,data = mtcars,col = c("pink","salmon"))

# Scatter plot
## 2 x Quantitative
plot(mtcars$hp,mtcars$mpg,pch = 16,col = "blue",main = "My first scatter plot",xlab = "Horse Power",ylab = "Miles Per Gallon")
cor(mtcars$hp,mtcars$mpg)
lm(mpg ~ hp , data = mtcars )
