#1. Tạo dataframe 
#Dataframe được tạo ra từ các Vector có chung độ dài

column1 <- c(1:3)
column2 <- c("Thu", "Anna","Tom")
column3 <- c(T,T,F)

dataset1 <- data.frame(column1,column2, column3)
#in 
#hiển thị ra cửa sổ Console
print (dataset1)
dataset1
#view dữ liệu 
View(dataset1)

#Tên của các cột
colnames(dataset1)

#Đổi tên cột 2
colnames(dataset1)[2] <- "Name"
dataset1
#Đổi tên cột hàng loạt 
colnames(dataset1) <- c("#","Name","Check")
dataset1

#2. Thêm dòng mới cho DataFrame
newRow <- c(4, "Minh Thu", T)
dataset2 <- rbind(dataset1, newRow)
dataset2

newRow <- data.frame(5, "Jenny", F)
names(newRow)<- c("#","Name", "Check")
dataset3 <-rbind(dataset2, newRow)
dataset3

#3.Thêm cột mới 
newColumn <- c("a","b","c","d","e")
dataset4 <- cbind(dataset3, newColumn)

dataset4$newColumn2<- c(1,2,3,4,5)

#4. Truy xuất dữ liệu 
#Truy xuất bằng chỉ số
dataset4[3,2] #dòng 3, cột 2

#Truy xuất dữ dữ liệu bằng chỉ số và tên cột
dataset4[3, "Check"]
 #Truy xuất bằng tên cột 
dataset4["Name"]
dataset4[,"Name"]
dataset4$Name 

#5. Các hàm thường dùng 
head(dataset4) #hiển thị vài dòng đầu 
tail(dataset4) #hiển thị vài dòng cuối
str(dataset4) #hiển thị cấu trúc dữ liệu
summary(dataset4)

#6. Thay đổi dữ liệu cột
dataset4$Check <-as.logical(dataset4$Check)
summary(dataset4)


#########BÀI TẬP
#####BỘ DỮ LIỆU IRIS
data() #lấy ra toàn bộ dataset được buil trong R
iris
View(iris)
str(iris)
summary (iris) #nhìn nhanh dữ liẹu
head (iris) #dữ liệu đầu
tail (iris) # dữ liệu cuối

CO2
View (CO2)

data()
esoph                     
View(esoph)