# BÀI TH???C HÀNH: PHÂN TÍCH CH???T LU???NG NU???C B???NG H???I QUY LOGISTIC
# ==========================================================

# Khai báo thu vi???n c???n thi???t
library(readr)
library(ggplot2)
# N???u chua có gói caret, b???n hãy ch???y l???nh: install.packages("caret")
library(caret) 

# =================================================
# Bu???c 1: D???c d??? li???u
# =================================================
water_potability <- read_csv("C:/Users/Minh Thu/Desktop/PHÂN TÍCH TR???C QUAN/lab_01/lab_03/water_potability.csv", show_col_types = FALSE)
# =================================================
# Bu???c 2: X??? lý Missing Values (Di???n Median)
# =================================================
for(col in names(water_potability)){
  if(is.numeric(water_potability[[col]])){
    water_potability[[col]][is.na(water_potability[[col]])] <- median(water_potability[[col]], na.rm = TRUE)
  }
}

# =================================================
# Bu???c 3: CHU???N HÓA D??? LI???U (Feature Scaling) - FIX L???I 1 L???P
# =================================================
# L???y danh sách các c???t là bi???n d???c l???p (b??? c???t Potability)
features <- setdiff(names(water_potability), "Potability")

# Hàm scale() s??? dua các bi???n v??? cùng m???t thang do
water_potability[features] <- scale(water_potability[features])

# Ép ki???u Potability thành Factor d??? ch???y mô hình phân lo???i
water_potability$Potability <- as.factor(water_potability$Potability)

# =================================================
# Bu???c 4: Chia d??? li???u Train/Test
# =================================================
set.seed(42)
train_index <- sample(1:nrow(water_potability), 0.8 * nrow(water_potability))

train_data <- water_potability[train_index, ]
test_data  <- water_potability[-train_index, ]

# =================================================
# Bu???c 5: Xây d???ng mô hình Logistic Regression
# =================================================
model <- glm(Potability ~ ., 
             data = train_data, 
             family = binomial(link="logit"))

# =================================================
# Bu???c 6: D??? doán
# =================================================
# =================================================
probabilities <- predict(model, newdata = test_data, type = "response")

# Xem th??? mô hình d??? doán xác su???t n???m trong kho???ng nào
print(summary(probabilities))

# L???y ngu???ng c???t là m???c trung bình c???a xác su???t thay vì 0.5 c???ng nh???c
threshold <- mean(probabilities)
cat("\nNgu???ng c???t (threshold) m???i du???c dùng là:", threshold, "\n")

# Phân lo???i d???a trên ngu???ng m???i
predicted_classes <- ifelse(probabilities > threshold, 1, 0)

predicted_classes <- factor(predicted_classes, levels = c(0, 1))
actual_classes <- factor(test_data$Potability, levels = c(0, 1))

# =================================================
# Bu???c 7: Dánh giá mô hình (Dùng caret d??? tránh l???i code cu)
# =================================================
# S??? d???ng hàm confusionMatrix c???a gói caret d??? tính toán d???y d??? các ch??? s???
conf_matrix <- confusionMatrix(predicted_classes, actual_classes, positive = "1")

cat("\n--- CÁC CH??? S??? DÁNH GIÁ ---\n")
cat("Accuracy:", round(conf_matrix$overall["Accuracy"], 4), "\n")
cat("Sensitivity (Recall):", round(conf_matrix$byClass["Sensitivity"], 4), "\n")
cat("Specificity:", round(conf_matrix$byClass["Specificity"], 4), "\n")
cat("Precision:", round(conf_matrix$byClass["Pos Pred Value"], 4), "\n")
cat("F1 Score:", round(conf_matrix$byClass["F1"], 4), "\n")

# =================================================
# Bu???c 8: V??? Confusion Matrix
# =================================================
cm <- table(Predicted = predicted_classes, Actual = actual_classes)
cm_df <- as.data.frame(cm)

ggplot(cm_df, aes(x = Actual, y = Predicted, fill = Freq)) +
  geom_tile(color = "black") +                  
  geom_text(aes(label = Freq), size = 6) +      
  scale_fill_gradient(low = "lightblue", high = "pink") + # Ch???nh màu gi???ng hình c???a b???n
  labs(
    title = "Confusion Matrix - Water Potability",
    x = "Actual (0 = Not Drinkable, 1 = Drinkable)",
    y = "Predicted"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold") 
  )

