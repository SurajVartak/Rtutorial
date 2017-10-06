#creating an expression that gives out logical values
2+2 == 5
3<4
#Assigning values to variables
x<-"Arr, matey!"
x<- 42
x
#using Source funtion to run a script
source("bottle1.R")
#Creating sequences using seq function
seq(5, 9, 0.5)
#Accessing vectors
sentence <- c('walk', 'the', 'plank')
sentence[3]
#assigning names to vector elements using names assignment function
ranks <- 1:3
names(ranks) <- c("first", "second", "third")
ranks
#using the barplot function
x<-c(5,6,7)
barplot(x)
names(x)<-c("England", "France", "Norway")
barplot(x)
#performing arithmatic operations on Vectors
a<-c(1,2,3)
a+1
a*2
a/2
sin(a)
#using plot function fr plotting X and Y variables
x <- seq(1, 20, 0.1)
y <- sin(x)
plot(x,y)
#creating a matrix of 3 rows and 4 coloumns
matrix(0, 3, 4)
#using the dim function for setting dimension in a matrix
plank<-1:8
dim(plank)<-c(2, 4)
print(plank)
#acessing elements in matrix
plank[2,3]
plank[1,4]
#assigning specific values to elements in matrix
plank[1,4] <- 0
plank[1,4]
#plotting matrix using contour function
contour(plank)
persp(plank)
persp(plank, expand=0.2)
#finding out the mean of a dataset and plotting it on the graph
limbs <- c(4, 3, 4, 3, 2, 4, 4, 4)
barplot(limbs)
abline(h=mean(limbs))
#finding out the median of a dataset and plotting it on the graph
median(limbs)
abline(h=median(limbs))
meanv<-mean(limbs)
#finding out the standard deviation of a dataset and plotting it on the graph
sd(limbs)
abline(h = sd(limbs))
deviation<-sd(limbs)
abline(h = meanv - deviation)
abline(h = meanv + deviation)
#Categorizing values in a vector using the factor function
chests <- c('gold', 'silver', 'gems', 'gold', 'gems')
types <- factor(chests)
print(types)
#To find out integers for underlying factors
as.integer(types)
#To find out factor levels
levels(types)
#Plotting factors
w<-c(300, 200, 100, 250, 150)
p<-c(9000, 5000, 12000, 7500, 18000)
plot(w,p)
plot(p,w)
#Using different plot characters for factors and plotting the legend
plot(w, p, pch=as.integer(types))
legend("topright", c("gems", "gold", "silver"), pch=1:3)
#Passing the Variables to a dataframe
loot<-data.frame(w,p,types)
print(loot)
#Accessing a dataframe
loot$p
#Loading dataframe with read function with comma seperated files
read.csv("loot.csv")
#Loading dataframe with read function with sperator strings other than commas
read.table("child.txt", sep="\t")
#Using the merge function to merge frame with common coloumn
loots <- read.csv("loot.csv")
children <- read.table("child.txt", sep="\t", header=TRUE)
merge(x = loots, y = children)
#finding out correlation between two coloumns in a data set
cor.test(loot$p, loot$w)
#To represent data points with the help of linear model
line<-lm(loot$p ~ loot$w)
abline(line)
