# Tên dataset: Marketing Campaign
# Mô tả: Dữ liệu khách hàng và hành vi mua sắm trong chiến dịch marketing
#
# Các biến quan trọng:


# Education: trình độ học vấn
# Marital_Status: tình trạng hôn nhân
# Income: thu nhập
# Kidhome / Teenhome: số trẻ em trong gia đình
# Recency: số ngày kể từ lần mua hàng gần nhất
# Response: khách hàng có phản hồi chiến dịch hay không

#Bước 1: Load và khám phá dữ liệu
#Load dữ liệu
marketing <- read.csv("../lab_02/marketing_campaign.csv", sep="\t")
# sep="\t" vì dataset được phân tách bằng tab


#xem dữ liệu
View(marketing)

#xem 6 dòng đầu
head(marketing)

# Kiểm tra cấu trúc dữ liệu( cho biết kiểu dữ liệu của từng biến )
str(marketing)

# Tóm tắt thống kê
summary(marketing)

# Xem tên các cột
colnames(marketing)

#Loại bỏ cột đầu tiên (có thể là cột ID không cần thiết)
head(marketing[,-1]) #xem trước khi xóa
marketing <- marketing [,-1] #xóa cột 1

#
#Lưu ý:
#
#
# [,-1] nghĩa là "lấy tất cả các dòng, loại bỏ cột 1"
#Luôn kiểm tra trước khi xóa để tránh mất dữ liệu quan trọng

# BƯỚC 2: XỬ LÝ MISSING DATA
# Tìm các dòng có missing
marketing[!complete.cases(marketing),]

# Đếm số dòng bị thiếu
length(marketing[!complete.cases(marketing),])

# Trong dataset này, missing chủ yếu nằm ở biến Income
# Xử lý biến số Numeric - Income

# Kiểm tra phân bố thu nhập
summary(marketing$Income)

# tính median (bỏ qua NA)
# na.rm=TRUE nghĩa là bỏ qua giá trị NA

median(marketing$Income, na.rm=TRUE)

# Điền missing value bằng median
# Median được chọn vì ít bị ảnh hưởng bởi outlier

marketing$Income[is.na(marketing$Income)] <- median(marketing$Income, na.rm=TRUE)
sum(is.na(marketing$Income))

# kiểm tra xem còn NA không
marketing$Income[is.na(marketing$Income)]

# BƯỚC 3: CHUYỂN CATEGORICAL DATA THÀNH FACTOR
#kiểm tra lại cấu trúc dữ liệu
str(marketing)

# Education - trình độ học vấn

summary(factor(marketing$Education))

#chuyển sang kiểu factor
marketing$Education <- factor(marketing$Education)

#kiểm tra lại 
summary(marketing$Education)


# Marital Status - tình trạng hôn nhân
summary(factor(marketing$Marital_Status))

marketing$Marital_Status <- factor(marketing$Marital_Status)

summary(marketing$Marital_Status)

# BƯỚC 4: XỬ LÝ BIẾN NGÀY THÁNG
# Dt_Customer là ngày đăng ký khách hàng

summary(marketing$Dt_Customer)

# Chuyển sang dạng Date
marketing$Dt_Customer <- as.Date(marketing$Dt_Customer, 
                                 format="%d-%m-%Y")

#kiểm tra lại kiểu dữ liệu
str(marketing$Dt_Customer)

# BƯỚC 6: XỬ LÝ BIẾN NHỊ PHÂN BINARY
# Các biến chiến dịch marketing (0 = no, 1 = yes)
# Các biến nhị phân trong dataset
binaryVariables <- c("AcceptedCmp3",
                     "AcceptedCmp4",
                     "AcceptedCmp5",
                     "AcceptedCmp1",
                     "AcceptedCmp2",
                     "Complain",
                     "Response")

# Xem dữ liệu
marketing[,binaryVariables]

# Kiểm tra từng biến
lapply(marketing[,binaryVariables], summary)

# Chuyển all biến binary thành factor
marketing[,binaryVariables] <- lapply(marketing[,binaryVariables], factor)

# Kiểm tra lại
str(marketing[,binaryVariables])

# BƯỚC 5: XỬ LÝ BIẾN SỐ (NUMERIC VARIABLES)

# Các biến chi tiêu của khách hàng
spendingVariables <- c("MntWines",
                       "MntFruits",
                       "MntMeatProducts",
                       "MntFishProducts",
                       "MntSweetProducts",
                       "MntGoldProds")

# Xem phân bố chi tiêu
lapply(marketing[,spendingVariables], summary)

# BƯỚC 8: FEATURE ENGINEERING
#Tạo biến mới
# Tổng chi tiêu
marketing$TotalSpending <- marketing$MntWines +
  marketing$MntFruits +
  marketing$MntMeatProducts +
  marketing$MntFishProducts +
  marketing$MntSweetProducts +
  marketing$MntGoldProds

#kiểm tra thống kê
summary(marketing$TotalSpending)

#Tạo biến mới
# Tổng số con trong gia đình
marketing$TotalChildren <- marketing$Kidhome + marketing$Teenhome

summary(marketing$TotalChildren)

# BƯỚC 6: KIỂM TRA KẾT QUẢ CUỐI

# Kiểm tra cấu trúc dữ liệu sau khi clean
str(marketing)

# Tóm tắt thống kê
summary(marketing)

# Kiểm tra missing
sum(!complete.cases(marketing))

# BƯỚC 7: PHÂN TÍCH NHANH

# Response: phản hồi chiến dịch marketing
table(marketing$Response)

# Education; trình độ học vấn 
table(marketing$Education)

# Marital Status: trình trạng hôn nhân
table(marketing$Marital_Status)

# Thống kê tổng chi tiêu
summary(marketing$TotalSpending)


# BƯỚC 8: VISUALIZATION

# Histogram thu nhập
hist(marketing$Income)

# Histogram TotalSpending
hist(marketing$TotalSpending)

# Boxplot Income theo Education
boxplot(Income ~ Education, data=marketing)

# Barplot Response
barplot(table(marketing$Response))


############################################################
# BƯỚC 9: LƯU DATASET SẠCH
############################################################

write.csv(marketing,
          "../lab_02/marketing-cleaned.csv",
          row.names = FALSE)


############################################################
# END OF SCRIPT
############################################################