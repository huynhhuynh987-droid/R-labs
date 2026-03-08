# bước 1: khai báo các thông số
chieu_dai <- 20
chieu_rong <- 10
don_vi <- "met"

#bước 2: tính toán chu vi và diện tính
chu_vi <- (chieu_dai+chieu_rong)*2
dien_tich <- chieu_dai*chieu_rong

#bước 3: sử dụng toán so sánh + logic
#kiểm tra nếu diện tích > 150 và chiều dài có lớn hơn
check_dk <- (dien_tich>150) & (chieu_dai> chieu_rong)

#bước 4: in kết quả 
print(paste("Chu vi la: ",chu_vi, don_vi))
ketQua <- paste("Diện tích là:",dien_tich,don_vi) #ctrl enter

#bước 5: kiểm tra kiểu dữ liệu
class(don_vi)
class(check_dk)

# bổ sung
help (print)
help(class)

class(check_dk) <- "character"
check_dk

# class() : kiểm tra kiểu dữ liệu

# is.numeric() : kiểm tra dữ liệu có phải là numeric hay không
# is.integer() : kiểm tra dữ liệu có phải là integer hay không
# is.logical() : kiểm tra dữ liệu có phải là logical hay không
# is.character(): kiểm tra dữ liệu có phải là character hay không

# Chuyển đổi kiểu
# as.numeric()
# as.integer()
# as.logical()
# as.character()
# as.Date()

a<-1.5
class (a)

b<-10
class(b)

is.integer(a)
is.integer(b)
is.numeric(b)

b<-6.89
class(b)
b<-as.integer(b)
class(b)
print(b)