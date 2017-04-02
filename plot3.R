## Insert library
library(ggplot2)

#### Reading my data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetting my data for Baltimore City, Maryland (fips == “24510”)
baltimore <- subset(NEI, fips == "24510")

# Combine total emissions according to each year and type and assign it to the variable baltimore_type
baltimore_type <- aggregate(Emissions ~ year + type, baltimore, sum)

## Use ggplot system and create "plot3.png"
png("plot3.png")
gplot <- ggplot(baltimore_type, aes(year, Emissions, color = type))
gplot + geom_line() + xlab("Year") + ylab(expression("Total Emissions (ton)")) + ggtitle("Total Emissions per type in Baltimore")
dev.off()