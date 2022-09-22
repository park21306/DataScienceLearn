## ridge/lasso regession

data("PimaIndiansDiabetes")
df <- PimaIndiansDiabetes

#Glimpse data
glimpse(df)

## 1. split data
set.seed(42)
id <- createDataPartition(y = df$diabetes,
                          p = 0.8 ,
                          list = FALSE)
train_df <- df[id,]
test_df <- df[-id,]
df %>%glimpse()


## 2. train model
## help with overfitting

set.seed(42)

# alpha = 0 ridge
# alpha = 1 lasso
myGrid <- expand.grid(alpha = 0:1,
                      lambda = seq(0.001,
                                  1,
                                  length=20))

regularized_model <- train(
    diabetes ~ .,
    data = train_df ,
    method = "glmnet" ,
    tuneGrid = myGrid ,
    trControl = trainControl(
        method = "cv" ,
        number = 5 ,
        verboseIter = TRUE
    )
)

## 3. test model
p <- predict(regularized_model , newdata = test_df)

confusionMatrix(p,
                test_df$diabetes,
                mode = "prec_recall",
                positive = "pos")
