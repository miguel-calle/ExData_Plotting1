library(data.table)
df<-read.csv("household_power_consumption.txt",sep=";")
electric=data.table(df)

#Extract subset of da
elec_days<-electric[Date %in% c("1/2/2007","2/2/2007")]

#Parse Data Types
elec_days[,Date:=as.Date(Date,"%d/%m/%Y")]
elec_days[,Global_active_power:=as.numeric(Global_active_power)/1000]
elec_days[,Sub_metering_1:=as.numeric(as.character(Sub_metering_1))]
elec_days[,Sub_metering_2:=as.numeric(as.character(Sub_metering_2))]
elec_days[,Sub_metering_3:=as.numeric(as.character(Sub_metering_3))]
elec_days[,Voltage:=as.numeric(as.character(Voltage))]
elec_days[,Global_reactive_power:=as.numeric(as.character(Global_reactive_power))]
elec_days[,Day_Time:=paste(Date,Time)]
x<-elec_days[,Day_Time]
x=strptime(x,format="%Y-%m-%d %H:%M:%S")
elec_days[,Day_Time:=data.table(x)]

#Draw the graph
plot(elec_days[,Day_Time],elec_days[,Global_active_power],type="n",xlab = "",ylab="Global Active Power (kilowatts)")
lines(elec_days[,Day_Time],elec_days[,Global_active_power])

#Export the result to PNG
dev.print(png,filename="plot2.png",width = 480, height = 480, units = "px")
dev.off()