## unziping and loading data to R
unzip(zipfile = "exdata_data_NEI_data.zip")

input_sum <- readRDS("summarySCC_PM25.rds")
input_class <- readRDS("Source_Classification_Code.rds")

file.remove("summarySCC_PM25.rds")
file.remove("Source_Classification_Code.rds") 

##data manipulation

inputBal <- subset(input_sum, input_sum$fips == "24510")
input_aggrBalt <- aggregate(Emissions ~ year, data=inputBal, sum)

# bar chart
png(file="plot2.png")
barplot(input_aggrBalt$Emissions ~ input_aggrBalt$year, main="Total Emissions in Baltimore City", xlab="Year", ylab="Emissions in tons")

dev.off()