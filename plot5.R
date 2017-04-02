#### Reading my data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetting my data for Baltimore City, Maryland (fips == “24510”)
baltimore <- subset(NEI, fips == "24510")

## Searching for "vehicle" matches and subset SCC according to vehicle values
vehicle_matches  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehicleSCC_subset <- SCC[vehicle_matches, ]

## Merge Baltimore data with vehicleSCC_subset DataFrame by "SCC"
balt_NEI_SCC <- merge(baltimore, vehicleSCC_subset, by = "SCC")

## Combine motor vehicle total emissions according to each year and assing it to variable venicle_emissions
vehicle_emissions <- tapply(balt_NEI_SCC$Emissions, balt_NEI_SCC$year, sum)

## Base plotting with barplot and create "plot5.png"
png("plot5.png")
barplot(vehicle_emissions, xlab = "Year", ylab = "Total Emission (ton)", main = "Total Emission from motor vehicles in Baltimore")
dev.off()