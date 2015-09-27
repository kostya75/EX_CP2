#Plot2

#read data from the project folder or working directory

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")



#summarize the data
NEI$year<-as.factor(NEI$year)

#subset data by Baltimore
BaltMD<-subset(NEI,fips=="24510")
totals<-aggregate(BaltMD$Emissions, by=list(Year=BaltMD$year), FUN=sum)
names(totals)[2]<-"TotEmissions"

#Build bar chart

barplot(totals$TotEmissions,names.arg=totals$Year, 
        col="blue",
        main="Total Emissions in Baltimore, MD: 1999-2008",
        xlab="Year",
        ylab="Total Emissions",
        axis.lty = 1)


# Add trend line. Regress Total Emissions on year. Currently year
# is a factor. Convert to numeric first. Note: factor are 1,2,3,4 but 
# since the interval between "true" years is the same it should be OK
# for exploratory chart

abline(lm(TotEmissions~as.numeric(Year),totals),lwd=5,col="red")


#Create Plot2 as a file
dev.copy(png,file="./Plot2.png", height=480, width=480,bg="white")
dev.off()
