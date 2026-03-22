#==============================================================================#
#       BÀI TẬP THỰC HÀNH PHÂN TÍCH DỮ LIỆU KHÁCH HÀNG (CLIENTS)               #
#==============================================================================#

# 1. Đọc dữ liệu từ file clients.csv
# Sử dụng stringsAsFactors = FALSE để tránh việc R tự ý chuyển chữ thành factor sớm
clients <- read.csv("clients.csv", stringsAsFactors = FALSE)

# 2. Xem cấu trúc dữ liệu và kiểm tra các lớp (classes)
View(clients)       # Mở bảng dữ liệu để quan sát trực quan
str(clients)        # Kiểm tra kiểu dữ liệu (numeric, character, int...)
summary(clients)    # Xem tóm tắt thống kê (Min, Max, Mean, NAs...)

# Xóa cột ID (thường là cột thứ 1, không có ý nghĩa phân tích số học)
clients <- clients[, -1]

# 3. Xử lý giá trị thiếu (Missing Values - NA)
################################################################################

# a) Kiểm tra xem những biến nào có chứa giá trị bị thiếu
colSums(is.na(clients))

# b) Xử lý biến Income và Year_Birth (CHÈN ĐOẠN CODE ĐÓ VÀO ĐÂY)
# Chuyển Income về numeric và ẩn cảnh báo "NAs introduced by coercion"
clients$Income <- suppressWarnings(as.numeric(as.character(clients$Income)))

# Điền NA cho Income bằng giá trị trung vị (Median)
clients$Income[is.na(clients$Income)] <- median(clients$Income, na.rm = TRUE)

# Điền NA cho Year_Birth bằng giá trị trung vị
clients$Year_Birth[is.na(clients$Year_Birth)] <- median(clients$Year_Birth, na.rm = TRUE)

# c) Đoạn mã dùng để điền Year_Birth (Đáp án cho câu hỏi 3c):
# clients$Year_Birth[is.na(clients$Year_Birth)] <- median(clients$Year_Birth, na.rm = TRUE)

################################################################################
# 4. Kiểm tra lại việc điền giá trị thiếu
# a) Kiểm tra xem tất cả các giá trị thiếu đã được điền đầy đủ chưa
sum(is.na(clients))
# b) Đoạn mã hiển thị tất cả các dòng vẫn còn chứa dữ liệu bị thiếu (nếu có):
clients[!complete.cases(clients), ]

# 5. Chuyển đổi sang kiểu Factor (Biến phân loại)
# a) Các biến định danh lặp lại nên là factor: Marital_Status, Kidhome, Teenhome...
# b) Đoạn mã ngắn nhất để chuyển đổi Marital_Status:
clients$Marital_Status <- as.factor(clients$Marital_Status)

# 6. Chuyển đổi sang kiểu Ordered Factor (Biến phân loại có thứ tự)
# b) Chuyển đổi Education theo thứ tự logic: Basic < 2n Cycle < Graduation < Master < PhD
clients$Education <- factor(clients$Education, 
                            levels = c("Basic", "2n Cycle", "Graduation", "Master", "PhD"), 
                            ordered = TRUE)

# 7. Chuyển đổi các biến khác sang lớp thích hợp (Thực hiện nốt bước 5)
clients$Kidhome <- as.factor(clients$Kidhome)
clients$Teenhome <- as.factor(clients$Teenhome)
# Có thể chuyển thêm Response hoặc Complain nếu có trong bộ dữ liệu
if("Response" %in% colnames(clients)) clients$Response <- as.factor(clients$Response)

# Kiểm tra lại cấu trúc lần cuối
str(clients)

# 8. Lưu kết quả vào file RData
save(clients, file = "clientsInR.RData")

# Thông báo hoàn tất
cat("--- Đã hoàn thành xử lý dữ liệu và lưu file clientsInR.RData ---\n")

