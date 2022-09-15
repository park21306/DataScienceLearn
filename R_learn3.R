#Data Prep(50-80%)
Species <- iris$Species
iris_data <- iris %>% select(-Species)

#KMEANS clustering(20-30%)
km_result <- kmeans(iris_data,3)
cluster_membership <- km_result$cluster

#Cross Check
table(Species,cluster_membership)

#Unsupervised Learning
