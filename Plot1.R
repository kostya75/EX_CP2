#Plot1

#read data from the project folder or working directory

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")



#summarize the data
NEI$year<-as.factor(NEI$year)

totals<-aggregate(NEI$Emissions, by=list(Year=NEI$year), FUN=sum)
names(totals)[2]<-"TotEmissions"

#Build bar chart

barplot(totals$TotEmissions,names.arg=totals$Year, 
        col="blue",
        main="Total Emissions 1999-2008",
        xlab="Year",
        ylab="Total Emissions",
        axis.lty = 1)
abline(lm(TotEmissions~as.numeric(Year),totals),lwd=5,col="red")


#Create Plot1 as a file
dev.copy(png,file="./Plot1.png", height=480, width=480,bg="white")
dev.off()
