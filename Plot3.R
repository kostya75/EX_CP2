#Plot3
library(ggplot2)

#read data from the project folder or working directory

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")



#summarize the data
NEI$year<-as.factor(NEI$year)

#subset data by Baltimore
BaltMD<-subset(NEI,fips=="24510")
totals<-aggregate(BaltMD$Emissions, by=list(Type=BaltMD$type,Year=BaltMD$year), FUN=sum)

#convert Year to numeric. Required for lm() to fit the line
x_labels<-levels(totals$Year)
totals$Year<-as.numeric(totals$Year)

#update names after aggregation
names(totals)[3]<-"TotEmissions"



#GGPLOT
#initiate ggplot
g<-ggplot(data=totals,aes(Year,TotEmissions))
p1<-g+geom_point()+
    geom_smooth(method="lm")+
    facet_grid(.~Type)+
    labs(title="Total Emissions by Type in Baltimore, MD: 1999-2008",
         y="Total Emissions")+
    scale_x_discrete(labels=x_labels) #restores labels to original from factor

#print chart
print(p1)

dev.copy(png,file="./Plot3.png", height=480, width=480,bg="white")
dev.off()

