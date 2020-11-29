
## unziping and loading data to R
unzip(zipfile = "exdata_data_NEI_data.zip")

input_sum <- readRDS("summarySCC_PM25.rds")
input_class <- readRDS("Source_Classification_Code.rds")

file.remove("summarySCC_PM25.rds")
file.remove("Source_Classification_Code.rds") 

##data manipulation

input_aggr <- aggregate(Emissions ~ year, data=input_sum, sum)

# bar chart
png(file="plot1.png")
barplot(input_aggr$Emissions ~ input_aggr$year, main="Total Emissions in United States", xlab="Year", ylab="Emissions in tons")

dev.off()