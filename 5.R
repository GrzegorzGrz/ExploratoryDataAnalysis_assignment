library(ggplot2)

## unziping and loading data to R
unzip(zipfile = "exdata_data_NEI_data.zip")

input_sum <- readRDS("summarySCC_PM25.rds")
input_class <- readRDS("Source_Classification_Code.rds")

file.remove("summarySCC_PM25.rds")
file.remove("Source_Classification_Code.rds") 

#subset motor vehicles from El.Sector
mot_veh <- grep("vehicle", input_class$EI.Sector, ignore.case=TRUE)

#subset all matching codes from input_sum
mot_veh_subset_class <- input_class[mot_veh,]$SCC
mot_veh_subset_input <- input_sum[input_sum$SCC %in% mot_veh_subset_class,]
#subset Baltimore
mot_veh_subset_inputBal <- subset(mot_veh_subset_input, mot_veh_subset_input$fips == "24510")
#aggegate
input_aggr <- aggregate(Emissions ~ year, data=mot_veh_subset_input, sum)

# bar chart
png(file="plot5.png")

ggplot(input_aggr, aes(factor(year), Emissions)) + geom_bar(stat="identity") + labs(x="year", y=("Total  Emission in Tons")) + 
  labs(title=("Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

#alternative
# qplot(year, Emissions, data=input_aggr, xlab="Year", ylab="Emissions in tons", main="Emissions from mor veh in Baltimore")


dev.off()

