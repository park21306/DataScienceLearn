##ggplot2
library(tidyverse)

# First Plot
ggplot(data = mtcars ,mapping = aes(x = hp , y = mpg)) + 
  geom_point() + 
  geom_smooth()+
  geom_rug()

ggplot(mtcars,aes(hp,mpg))+
  geom_point(size = 2,col="salmon",alpha = 0.2)

ggplot(mtcars,aes(hp))+
  geom_histogram(bins = 10,fill = "salmon",alpha = 0.5)

ggplot(mtcars,aes(hp))+
  geom_boxplot()

p <- ggplot(mtcars,aes(hp))
p+geom_histogram(bins = 20)
p+geom_density()
p+geom_boxplot()

## Box plot by groups
diamonds %>% 
  count(cut)

ggplot(diamonds,aes(cut))+
  geom_bar(fill = "salmon")

ggplot(diamonds,mapping = aes(cut,fill = cut))+
  geom_bar()

ggplot(diamonds,mapping = aes(cut,fill = color))+
  geom_bar(position = "stack")

ggplot(diamonds,mapping = aes(cut,fill = color))+
  geom_bar(position = "dodge")

ggplot(diamonds,mapping = aes(cut,fill = color))+
  geom_bar(position = "fill")

### SCATTER PLOT
set.seed(99)
small_diamonds <- sample_n(diamonds,5000)

ggplot(small_diamonds,aes(carat,price))+
  geom_point()

#### FACET :small multiple
ggplot(small_diamonds,aes(carat,price))+
  geom_point()+
  geom_smooth(method = "lm")+
  facet_wrap(~color,ncol = 2)+
  theme_minimal()+
  labs(title = "Relationship between carat and price by color",
       x = "Carat",
       y = "Price USD",
       caption = "Source : Dimonds from ggplot2 package")


#### Finam Example
ggplot(small_diamonds,aes(carat,price,col = cut))+
  geom_point(size = 3 ,alpha = 0.2)+
  facet_wrap(~color,ncol = 2)+
  theme_minimal()

  