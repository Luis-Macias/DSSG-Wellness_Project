require(xlsx)
require(prophet)
require(dplyr)

#removing the extra number that result from writing the table

df <- read.xlsx("../data/num_visits_per_day.xlsx",1,header=TRUE, colIndex = c(2,3))
names(df) <- c("ds","y")
y = df$y
View(df)


v <- prophet(df)
future <- make_future_dataframe(v,periods = 365, freq =  "d", include_history = TRUE)

forecast <- predict(v,future)
tail(future[c("ds","yhat","yhat_lower","yhat_upper")])
plot(v,forecast)
