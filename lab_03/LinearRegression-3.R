# ==============================================================
# PH???N M??? R???NG: SO SÁNH NHI???U MÔ HÌNH REGRESSION
# ==============================================================

# Cài thêm package c???n thi???t
if (!require(randomForest)) install.packages("randomForest")
if (!require(e1071))       install.packages("e1071")   # SVM
if (!require(FNN))         install.packages("FNN")     # KNN

library(randomForest)
library(e1071)
library(FNN)

# --------------------------------------------------------------
# CHU???N HÓA D??? LI???U (C???N CHO KNN, SVM)
# --------------------------------------------------------------
preProcValues <- preProcess(X_train, method = c("center", "scale"))

X_train_scaled <- predict(preProcValues, X_train)
X_test_scaled  <- predict(preProcValues, X_test)

# --------------------------------------------------------------
# HÀM DÁNH GIÁ MODEL
# --------------------------------------------------------------
evaluate_model <- function(y_true, y_pred) {
  mse  <- mean((y_true - y_pred)^2)
  rmse <- sqrt(mse)
  mae  <- mean(abs(y_true - y_pred))
  r2   <- 1 - sum((y_true - y_pred)^2) / sum((y_true - mean(y_true))^2)
  
  return(c(MSE = mse, RMSE = rmse, MAE = mae, R2 = r2))
}

# --------------------------------------------------------------
# 1. LINEAR REGRESSION
# --------------------------------------------------------------
lm_model <- lm(y_train ~ ., data = X_train)
lm_pred  <- predict(lm_model, newdata = X_test)

lm_metrics <- evaluate_model(y_test, lm_pred)

# --------------------------------------------------------------
# 2. KNN REGRESSION
# --------------------------------------------------------------
knn_pred <- knn.reg(
  train = X_train_scaled,
  test  = X_test_scaled,
  y     = y_train,
  k     = 5
)$pred

knn_metrics <- evaluate_model(y_test, knn_pred)

# --------------------------------------------------------------
# 3. SVM REGRESSION
# --------------------------------------------------------------
svm_model <- svm(
  x = X_train_scaled,
  y = y_train,
  type = "eps-regression"
)

svm_pred <- predict(svm_model, X_test_scaled)

svm_metrics <- evaluate_model(y_test, svm_pred)

# --------------------------------------------------------------
# 4. RANDOM FOREST
# --------------------------------------------------------------
rf_model <- randomForest(
  x = X_train,
  y = y_train,
  ntree = 100
)

rf_pred <- predict(rf_model, X_test)

rf_metrics <- evaluate_model(y_test, rf_pred)

# --------------------------------------------------------------
# T???O B???NG SO SÁNH
# --------------------------------------------------------------
results <- data.frame(
  Model = c("Linear Regression", "KNN", "SVM", "Random Forest"),
  MSE   = c(lm_metrics["MSE"], knn_metrics["MSE"], svm_metrics["MSE"], rf_metrics["MSE"]),
  RMSE  = c(lm_metrics["RMSE"], knn_metrics["RMSE"], svm_metrics["RMSE"], rf_metrics["RMSE"]),
  MAE   = c(lm_metrics["MAE"], knn_metrics["MAE"], svm_metrics["MAE"], rf_metrics["MAE"]),
  R2    = c(lm_metrics["R2"], knn_metrics["R2"], svm_metrics["R2"], rf_metrics["R2"])
)

# S???p x???p theo RMSE (nh??? nh???t là t???t nh???t)
results <- results[order(results$RMSE), ]

cat("\n===== B???NG SO SÁNH MODEL =====\n")
print(results)

