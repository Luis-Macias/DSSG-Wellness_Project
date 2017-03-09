require(prophet)
require(dplyr)
require(xlsx)

raw.food <- read.csv("../data/raw_food_pantry.csv",header= TRUE)
View(raw.food)
summary(raw.food)

#changing the names of our rows 
names(raw.food) <- c("Day","ID")
#checking the class of our time stamped data
raw.food.day <- raw.food$Day
class(raw.food.day)
#converting our raw time stamp data intoo a Date Class for easier use
raw.food.day <- as.character(raw.food.day)
day <- as.Date.character(raw.food.day, "%m/%d/%y")

#adding in the cleaner simplified data into a new column 
raw.food$clean_day <- day

#omiting NA's where ever found in our data set only reslutsing the  loss of <100 rows

raw.food <- na.omit(raw.food)
names(raw.food) <- c("TimeStamp","ID","Day")

#Error in our simplfied day several rows were misinterpurted as 2020 due to lack of formatting in data 
fixed_day<- gsub(pattern = "2020", replacement = "2016", as.character(raw.food$Day))
raw.food$Day <- as.Date(fixed_day)

#using dplyr for grouping days for number of visits
grouped_raw_food <- group_by(raw.food, Day)
#Table with days of the food pantry and the number of visits, 
visits <- summarise(grouped_raw_food,visits = n())
visits
#exporting xlsx for FBprophet use
write.xlsx(x = visits , file = "num_visits_per_day.xlsx",
           sheetName = "Visits", row.names = TRUE)

