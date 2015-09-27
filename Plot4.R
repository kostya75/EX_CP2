#Plot4
library(ggplot2)

#read data from the project folder or working directory

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")



#select coal related SCC
coalSCC<-SCC[grep("Coal", SCC$EI.Sector, ignore.case = TRUE),]

#subset the data to only COAL-related

coalNEI<-merge(NEI,coalSCC,by="SCC",all=FALSE)

#summarize the data
#NEI$year<-as.factor(NEI$year)


totals<-aggregate(coalNEI$Emissions, by=list(Year=coalNEI$year), FUN=sum)
#convert Year to numeric. Required for lm() to fit the line
totals$Year<-as.numeric(levels(totals$Year))
names(totals)[2]<-"TotEmissions"

#Build bar chart - BASE

#barplot(totals$TotEmissions,names.arg=totals$Year, 
#        col="blue",
#        main="Total Emissions Coal Related: 1999-2008",
#        xlab="Year",
#        ylab="Total Emissions",
#        axis.lty = 1
#    )
#
#
# Add trend line. Regress Total Emissions on year. Currently year
# is a factor. Convert to numeric first. Note: factor are 1,2,3,4 but 
# since the interval between "true" years is the same it should be OK
# for exploratory chart

#abline(lm(TotEmissions~as.numeric(Year),totals),lwd=5,col="red")

#QPLOT as no specific system was mentioned

qplot(Year,TotEmissions,data=totals,
      geom=c("point","smooth"),method="lm",lwt=5,
      main="Total Emissions Coal Related: 1999-2008",
      ylab="Total Emissions"
      )

dev.copy(png,file="./Plot4.png", height=480, width=480,bg="white")
dev.off()
