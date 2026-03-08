#date
#number
#string
#...

#dữ liệu số thực; tuổi, chiều cao, điểm số
#dữ liệu văn bản tự do: tên người, bài viết
#dữ liệu số nguyên: ID, mã số,..

#dữ liệu thể loại(categorical data):
#color: "red", "blue", "green",...
#value: "low", "medium", "high",...
#education: "high school", "Bacherlor", "Master",...
#grades: "A", "B", "C",...
# => FACTOR

#Factor là kiểu dữ liệu đặc biệt trong R 
#dùng để lưu trữ dữ liệu phân loại (categorical data)
#với các mức độ(levels) xác định

#Unordered Factor (Factor không có thứ tự)
colors <- factor (c("red","green", "blue", "pink"))

#Ordered Factor(Factor có thứ tự)
ratings <- factor (c("low","high", "medium", "high"),
                   levels = c ("low","medium","high"), #low <medium < high
                   ordered =  TRUE
)
                
str (ratings)

# ví dụ:
# dữ liệu giáo dục
education <- factor( c("High School", "Bachelor", "Master", "PhD"),
                     levels = c("High School", "Bachelor", "Master", "PhD"),
                     ordered = TRUE)
str(education)
levels(education)

# tạo dữ liệu điểm số của học sinh
grades <- factor(
  c("Giỏi", "Khá", "Trung bình", "Giỏi", "Khá", "Yếu"),
  levels = c("Yếu", "Trung bình", "Khá", "Giỏi"),
  ordered = TRUE  # Có thứ tự từ yếu đến giỏi
)

table(grades)

# Khảo sát khách hàng
satisfaction <- factor(
  c("Rất thích", "Thích", "Bình thường", "Không thích", 
    "Thích", "Rất thích", "Bình thường"),
  levels = c("Không thích", "Bình thường", "Thích", "Rất thích"),
  ordered = TRUE
)

table(satisfaction)

# Vẽ biểu đồ
barplot(table(satisfaction))

# Kích cỡ áo
sizes <- factor(
  c("M", "L", "S", "XL", "M", "S", "M", "L", "XL", "M"),
  levels = c("S", "M", "L", "XL"),
  ordered = TRUE
)

# thống kê
summary(sizes)