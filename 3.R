library(ggplot2)

## unziping and loading data to R
unzip(zipfile = "exdata_data_NEI_data.zip")

input_sum <- readRDS("summarySCC_PM25.rds")
input_class <- readRDS("Source_Classification_Code.rds")

file.remove("summarySCC_PM25.rds")
file.remove("Source_Classification_Code.rds") 

##data manipulation
input_sum <- as_tibble(input_sum)
input_class <- as_tibble(input_class)

#subset Baltmore 
inputBal <- subset(input_sum, input_sum$fips == "24510")
input_aggrBalt <- aggregate(Emissions ~ year + type, data=inputBal, sum)

# bar chart
png(file="plot3.png")
qplot(year, Emissions, data=input_aggrBalt, color=type, geom="path", xlab="Year", ylab="Emissions in tons", main="Emissions by type in Baltimore City")

dev.off()

