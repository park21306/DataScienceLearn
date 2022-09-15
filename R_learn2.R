##data transformation / data viz 101

#dplyr
select(mtcars,1:3,5,11)

#pipe operator
mtcars %>%
  #step 1 select column
  select(mile_per_gallon = mpg,auto_manual = am,hourse_power = hp,weight = wt) %>%
#select 2 filter row
  filter(mile_per_gallon <= 15)%>%
#select 3 sort HP
  arrange(desc(hourse_power))
#data visualization
hist(mtcars$hp)
plot(mtcars$hp,mtcars$mpg,pch=16,col = "red")
#modern graphics
ggplot(mtcars,aes(hp,mpg))+geom_smooth()+geom_point()+geom_rug()+theme_minimal()+labs(title = "hellow world")
