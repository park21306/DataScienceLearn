# Pima Indian Diabetes

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


## 2. train model
set.seed(99)
myGrid <- data.frame(cp = seq(0.001,0.3,by =0.005))
tree_model <- train(diabetes ~ .,
                    data = train_df ,
                    method = "rpart",
                    tuneGrid  = myGrid,
                    trControl = trainControl(
                        method = "cv",
                        number = 5
                    )
)
## 3. test model

rpart.plot(tree_model$finalModel)
