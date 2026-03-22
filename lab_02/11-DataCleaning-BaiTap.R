# Đọc dữ liệu
clients <- read.csv("clients.csv")

# Khám phá dữ liệu
View(clients)
str(clients)
summary(clients)

# Xóa cột ID
clients <- clients[,-1]

# Kiểm tra missing
colSums(is.na(clients))

# Điền NA
str(clients$Income) clients$Income <- as.numeric(as.character(clients$Income)) median(clients$Income, na.rm=TRUE) # Điền missing value bằng median # Median được chọn vì ít bị ảnh hưởng bởi outlier clients$Year_Birth[is.na(clients$Year_Birth)] <- median(clients$Year_Birth, na.rm = TRUE) clients$Income[is.na(clients$Income)] <- median(clients$Income, na.rm=TRUE) sum(is.na(clients$Year_Birth)) colSums(is.na(clients)) # kiểm tra xem còn NA không clients$Income[is.na(clients$Income)
# Kiểm tra lại
sum(is.na(clients))

# Hiển thị dòng còn NA
clients[!complete.cases(clients),]

# Convert factor
clients$Marital_Status <- factor(clients$Marital_Status)

# Ordered factor
clients$Education <- factor(clients$Education,
                            levels=c("Basic","2n Cycle","Graduation","Master","PhD"),
                            ordered=TRUE)

# Lưu dữ liệu
save(clients, file="clientsInR.RData")