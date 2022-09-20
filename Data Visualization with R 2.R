## data visualization

## 1. nuber of variables
## 2. data types

library(tidyverse)

## basic ggplot2
## grammar of graphics
## data, mapping ,geommetry
ggplot(mtcars,
       mapping = aes(mpg)) +
    geom_histogram(bins = 5,fill = "salmon1")


ggplot(mtcars,
       mapping = aes(mpg)) +
    geom_density()


myPlot <- ggplot(mtcars ,
       aes(wt,mpg))+
    geom_point(col = "salmon") + 
    geom_smooth(method = "lm",se = FALSE) +
    geom_rug() +
    theme_minimal()


## Highlight specific data

df1 <- mtcars %>%
    filter(wt < 5)
df2 <- mtcars %>%
    filter(wt >= 5)
    
ggplot() +
    geom_point(df1 ,
               mapping = aes(wt ,mpg) ,
               col = "salmon" ,
               size = 3) +

    geom_point(df2 ,
               mapping = aes(wt ,mpg) ,
               col = "salmon4" ,
               size = 3)


## customization

mtcars <- mtcars %>%
    mutate(am = factor(am,
                       levels = c(0,1),
                       labels = c("Auto","Manual")))

mtcars <- mtcars %>%
    mutate(vs = factor(vs,
                       levels = c(0,1),
                       labels = c("V-Shaped","Straight")))


ggplot(data = mtcars,
       mapping = aes(wt,mpg, col=am ,size = hp )) +
    geom_point(alpha = 0.8) + 
    theme_minimal() +
    labs(
        title = "Scatter plot Weight x MPG",
        subtitle = " We found negative correlation between two negative" ,
        caption = "Data Source : RStudio 2022",
        x = "Weight (Tonne)",
        y = "Miles Per Gallom"
    )


## diamonds built-in dataset
library(tidyverse)
view(diamonds)


## EDA => Exploratory Data Analysis
## helper function
qplot(price,
      data = diamonds,
      geom = "histogram",
      bins = 100)

## Overplotting
qplot(x = carat,
      y = price,
      data = diamonds,
      geom = "point",
      alpha = 0.1)

ggplot(diamonds ,
       aes(carat,price))+
    geom_point(alpha = 0.05)
    

## random data in dplyr
set.seed(42) # lock result from sample_n
diamonds %>%
    sample_n(2000) %>%
    ggplot(aes(carat,price))+
    geom_point(alpha = 0.3)


set.seed(42) # lock result from sample_n
diamonds %>%
    sample_frac(0.01) %>%
    ggplot(aes(carat,price))+
    geom_point(alpha = 0.3)


## Facet ggplot
ggplot(diamonds %>% sample_n(1000),
       aes(carat,
           price,
           col = cut))+
    geom_point(alpha = 0.5)+
    facet_wrap(~cut ,ncol =2) + 
    theme_minimal()


## Facet Grid => more than one dimension
ggplot(diamonds %>% sample_n(1000),
       aes(carat,
           price,
           col = cut))+
    geom_point(alpha = 0.5)+
    geom_smooth(col = "red")+
    facet_grid(clarity ~cut)+
    theme_minimal()

## Bar Chart => One Variable/Factor
ggplot(diamonds,
       aes(cut,fill = cut))+
    geom_bar(aes(fill = cut))+
    theme_minimal()


ggplot(diamonds,
       aes(cut,fill = color))+
    geom_bar(position = "dodge")+
    theme_minimal()

ggplot(diamonds,
       aes(cut,fill = color))+
    geom_bar(position = "fill")+
    theme_minimal()


ggplot(diamonds,
       aes(cut,fill = color))+
    geom_bar(position = "identity")+
    theme_minimal()


ggplot(diamonds,
       aes(cut,fill = color))+
    geom_bar(position = "stack")+
    theme_minimal()


## Change Manual Color
ggplot(mtcars,
       aes(wt,mpg,col = am)) +
    geom_point(size = 5,alpha = 0.8)+
    theme_minimal() +
    scale_color_manual(values = c("salmon","pink"))


p1 <- ggplot(mtcars,
       aes(wt,mpg))+
    theme_minimal()

p1+geom_point(aes(col = hp),
              size = 5)+
    scale_color_gradient(low = "salmon",
                         high = "pink")


## back to diamond
ggplot(diamonds,
       aes(color,fill=color))+
    geom_bar() +
    scale_fill_manual(
        values = c("pink",
                   "salmon",
                   "salmon2",
                   "salmon3",
                   "salmon4",
                   "green",
                   "black"))
    ## scale_color_manual , scale_fill_manual


library(ggthemes)
library(plotly)
myplot <- diamonds %>%
    sample_n(2000) %>%
    ggplot(aes(carat,
               price,
               col = cut))+
    geom_point(alpha =0.5)+
    theme_economist()

ggplotly(myplot)
