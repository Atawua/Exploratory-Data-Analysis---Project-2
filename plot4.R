#### Reading my data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Searching for "coal" matches and subset SCC according to coal combustion
coal_matches  <- grepl("coal", SCC$Short.Name, ignore.case = TRUE)
coalSCC_subset <- SCC[coal_matches, ]

## Merge the two DataFrames by "SCC"
NEI_SCC <- merge(NEI, coalSCC_subset, by="SCC")

## Combine total coal combustion emissions according to each year and assing it to variable coal_emissions
coal_emissions <- tapply(NEI_SCC$Emissions, NEI_SCC$year, sum)

## Base plotting with barplot and create "plot4.png"
png("plot4.png")
barplot(coal_emissions, xlab = "Year", ylab = "Total Emission (ton)", main = "Total Emission from Coal Combustion")
dev.off()