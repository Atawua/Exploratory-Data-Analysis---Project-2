## Insert library
library(ggplot2)

#### Reading my data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetting my data for Baltimore City, Maryland (fips == “24510”)
baltimore <- subset(NEI, fips == "24510")

## Subsetting my data for Los Angeles City, California (fips == "06037")
los_angeles <- subset(NEI, fips == "06037")

## Searching for "vehicle" matches and subset SCC according to vehicle values
vehicle_matches  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehicleSCC_subset <- SCC[vehicle_matches, ]

## Merge Baltimore data with vehicleSCC_subset DataFrame by "SCC" and create the comparing variable of the city
balt_NEI_SCC <- merge(baltimore, vehicleSCC_subset, by = "SCC")
balt_NEI_SCC$City <- "Baltimore City"

## Merge Baltimore data with vehicleSCC_subset DataFrame by "SCC" and create the comparing variable of the city
los_angeles_NEI_SCC <- merge(los_angeles, vehicleSCC_subset, by = "SCC")
los_angeles_NEI_SCC$City <- "Los Angeles County"

## Combine DataFrames
losAngeles_Baltimore <- rbind(balt_NEI_SCC,los_angeles_NEI_SCC)

# Combine total emissions according to each year and type and assign it to the variable losAngeles_baltimore_plot
losAngeles_Baltimore_plot <- aggregate(Emissions ~ year + City, losAngeles_Baltimore, sum)

## Use ggplot system and create "plot6.png"
png("plot6.png")
gplot <- ggplot(losAngeles_Baltimore_plot, aes(year, Emissions, color = City))
gplot + geom_line() + xlab("Year") + ylab("Total Emissions (ton)") + ggtitle("Total Emissions from motor vehicle sources in Baltimore City and Los Angeles County")
dev.off()
