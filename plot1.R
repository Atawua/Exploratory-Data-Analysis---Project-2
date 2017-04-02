## Reading my data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Grouping total emissions per year and assing it to the variable grouped_emissions
grouped_emissions <- tapply(NEI$Emissions, NEI$year, sum)

## Base plotting with barplot and create "plot1.png"
png("plot1.png")
barplot(grouped_emissions, xlab = "Year", ylab = "Total Emission (ton)", main = "Annual Emission")
dev.off()