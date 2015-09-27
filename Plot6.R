#Plot6
library(ggplot2)

#read data from the project folder or working directory

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")



#summarize the data
NEI$year<-as.factor(NEI$year)

#subset data by Baltimore and type="ON-ROAD"
BaltLA<-subset(NEI,fips %in% c("24510","06037") & type=="ON-ROAD")


totals<-aggregate(BaltLA$Emissions, by=list(Year=BaltLA$year,Fips=BaltLA$fips), FUN=sum)

#convert Year to numeric. Required for lm() to fit the line
totals$Year<-as.numeric(levels(totals$Year))
#update names after aggregation
names(totals)[3]<-"TotEmissions"


totals$City<-sapply(totals$Fips,function(x) { 
    if(x=="24510") {
        "Baltimore"
    }else{
        "Los Angeles"}
}
)  


qplot(Year,TotEmissions,data=totals, 
      color=City, 
      facets=.~City,
      geom=c("point","smooth"),method="lm",
      main="Baltimore vs. Los Angeles, Motor Vehicle Emissions: 1999-2008",
      ylab="Motor Vehicle Emissionss"
      )

dev.copy(png,file="./Plot6.png", height=480, width=480,bg="white")
dev.off()


