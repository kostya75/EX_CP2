#Plot5
library(ggplot2)

#read data from the project folder or working directory

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")



#summarize the data
NEI$year<-as.factor(NEI$year)

#subset data by Baltimore and type="ON-ROAD"
BaltMD<-subset(NEI,fips=="24510" & type=="ON-ROAD")
totals<-aggregate(BaltMD$Emissions, by=list(Year=BaltMD$year), FUN=sum)

#convert Year to numeric. Required for lm() to fit the line
totals$Year<-as.numeric(levels(totals$Year))
#update names after aggregation
names(totals)[2]<-"TotEmissions"




#GGPLOT
#initiate ggplot
g<-ggplot(data=totals,aes(Year,TotEmissions))
p1<-g+geom_point()+
    geom_smooth(method="lm")+
    labs(title="Motor Vehicle Emissions in Baltimore, MD: 1999-2008",
         y="Motor Vehicle Emissions"
    )
print(p1)

dev.copy(png,file="./Plot5.png", height=480, width=480,bg="white")
dev.off()
