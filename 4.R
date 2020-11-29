library(ggplot2)

## unziping and loading data to R
unzip(zipfile = "exdata_data_NEI_data.zip")

input_sum <- readRDS("summarySCC_PM25.rds")
input_class <- readRDS("Source_Classification_Code.rds")

file.remove("summarySCC_PM25.rds")
file.remove("Source_Classification_Code.rds") 

#subset Comb coal from El.Sector
comb_coal <- grep("comb.*coal", input_class$EI.Sector, ignore.case=TRUE)

#subset all matching codes from input_sum
Comb_coal_subset_class <- input_class[comb_coal,]$SCC
Comb_coal_subset_input <- input_sum[input_sum$SCC %in% Comb_coal_subset_class,]

input_aggr <- aggregate(Emissions ~ year, data=Comb_coal_subset_input, sum)

# bar chart
png(file="plot4.png")
qplot(year, Emissions, data=input_aggr, xlab="Year", ylab="Emissions in tons", main="Emissions from Comb. Coal in USA")

dev.off()

