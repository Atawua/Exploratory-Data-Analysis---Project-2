## Reading my data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetting my data for Baltimore City, Maryland (fips == “24510”)
baltimore <- subset(NEI, fips == "24510")

## Grouping total emissions per year for Baltimore and assing it to the variable baltimore_emissions
baltimore_emissions <- tapply(baltimore$Emissions, baltimore$year, sum)

## Base plotting with barplot and create "plot2.png"
png("plot2.png")
barplot(baltimore_emissions, xlab = "Year", ylab = "Total Emission (ton)", main = "Annual Emission in Baltimore")
dev.off()