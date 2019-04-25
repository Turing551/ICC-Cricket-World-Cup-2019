
# Required Data
data = read.csv("Data_Training.csv")
data$X = NULL
data$match_url = NULL
data = data[!(rowSums(is.na(data))),]

# Train-Test split
set.seed(64)
train_rows = sample(1:nrow(data), round(0.75*nrow(data),digits=0)) 
data_train = data[train_rows, ]
data_test = data[-train_rows, ]

# X(predictors) and y(output) for Neural network
x_train = subset(data_train, select = -c(Output))
y_train = subset(data_train, select = c(Output))
x_test = subset(data_test, select = -c(Output))
y_test = subset(data_test, select = c(Output))

# Lasso for Variable Selection
x = model.matrix(~. , x_train)
y = as.matrix(y_train)
glm <- glmnet::cv.glmnet(x=x,y=y,type.measure='mse',nfolds=10,alpha=1)
plot(glm)
co<-coef(glm,s = "lambda.1se")
inds<-which(co!=0)
variables<-row.names(co)[inds]
variables<-variables[!(variables %in% '(Intercept)')]
vars=as.character(paste(variables, collapse='+'))

# Logistic Regression
formula = paste("Output ~ ", vars, sep="")
lgm <- glm(formula ,data = data_train, family = binomial(link = "logit"))

# Training Accuracy
train_fitted.results = ifelse(lgm$fitted.values > 0.5, 1, 0)
train_misClasificError <- mean(train_fitted.results != data_train$Output)
print(paste('Training Accuracy ',round(1-train_misClasificError, 4)*100, '%', sep = ''))

# Predicing on the test dataset
test_results = predict.glm(lgm,newdata = x_test, type = "response")
test_fitted.results <- ifelse(test_results > 0.5,1,0)
data_test$Prediction = test_fitted.results
data_test$Pred_Prob = test_results
test_misClasificError <- mean(test_fitted.results != data_test$Output)
print(paste('Testing Accuracy ',round(1-test_misClasificError, 4)*100, '%', sep = ''))

# Predicting results on 2019 data
data_2019 = read.csv("Data_Testing_2019.csv")
data_2019$X = NULL

x_2019 = subset(data_2019, select = -c(Match, Team1, Team2))
results_2019 = predict.glm(lgm,newdata = x_2019, type = "response")
fitted.results_2019 <- ifelse(results_2019 > 0.5,1,0)
data_2019$Result = fitted.results_2019

# Analysis who wins the most number of matches
winner = function(x){
  if (x$Result == 1){
    x$Winning_Team = x$Team1}
  else {
    x$Winning_Team = x$Team2}
  return (x)
}

winner = function(x){
  if (x["Result"] == 1){
    x["Winning_Team"] = x["Team1"]}
  else {
    x["Winning_Team"] = x["Team2"]}
  return (x)
}

data_2019_final = as.data.frame(t(apply(data_2019,1, winner)))
results_2019 <- data_2019_final %>% group_by(Winning_Team) %>% 
summarise(Number_of_wins = n())
results_2019 = results_2019[order(results_2019$Number_of_wins, decreasing = TRUE),]
print(results_2019)

