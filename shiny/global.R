library(data.table)

data(mtcars)

data <- data.table(mtcars)
#class(data)

## create mpg group variable 
data[, mpg_group := ifelse(mpg <=20, "A", "B")]

## factor
data[, mpg_group := lapply(.SD, as.factor), .SDcols = "mpg_group"]
