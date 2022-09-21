library(tidyverse)
library(caret)
library(mlbench)

## example linear regression
head(mtcars)

# mpg = f(hp,wt,am) = b0+(b1*hp)+(b2*wt)+(b3*am)
model_lm <- lm(mpg ~ hp + wt +am,
               data = mtcars)


# caret Interface
set.seed(42)
model_lm_caret <- train(mpg ~.,
      data = mtcars , 
      method = "lm") # algorithm

model_lm_caret$finalModel


## your first model -knn
## load data set BostonHousing

data("BostonHousing")

## 1. split Data


train_test_split <- function(df,train_size = 0.8){
    set.seed(42)
    n <- nrow(df)
    id <- sample(1:n ,size = n* train_size)
    train_df <- df[id,]
    test_df <- df[-id,]
    return(list(train = train_df,test  = test_df))
}

splite_data <- train_test_split(BostonHousing ,0.7)
train_df <- splite_data$train
test_df <- splite_data$test


## 2. Train Model
## Grid Search Hyperparameter Tuning


grid_k <- data.frame(k = 2:9)

ctrl <- trainControl(
    method = "repeatedcv", 
    number = 5 , 
    repeats = 5
)

## ctrl <- trainControl(
## method = "boot", 
    ## number = 5 
##)
## ctrl <- trainControl(
## method = "cv", 
## number = 5 
##)



set.seed(42)
knn_model <- train(medv ~ crim  + rm + tax + zn + nox,
                   data = train_df , 
                   method = "knn" ,
                   metric = "RMSE" ,
                   #tuneLength = 5
                   tuneGrid = grid_k , 
                   trControl = ctrl
                   )
## Predict Train Data
pred_medv_train <- predict(knn_model)
train_rmse <- sqrt(mean(train_df$medv - pred_medv_train)**2)


## 3. Test Model
## Scoring => Prediction


pred_medv <- predict(knn_model,
                     newdata = test_df)
test_rmse <- sqrt(mean((test_df$medv - pred_medv) **2))

## Save Model
saveRDS(knn_model,"knn_model_repeatedcv.RDS")


## Load Model
knn_model <- readRDS("knn_model_repeatedcv.RDS")
