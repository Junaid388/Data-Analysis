library(readxl)									# package for reading excel file
library(XML)									#package for working xm, html files
library(rlist)									#cleaning the list
library(data.table)								#for binding data frames
data<-read_excel("Input.xlsx")					#reading the Input file
data<-as.data.frame(data)						#converting the file to data frame
data$ID <-1:nrow(data)							#adding column ID's to the file
data<-data[,c(7,1:6)]							#putting ID at the first column
data2<-data[0,]									#creating a data frame to store the result

for(j in seq(1:nrow(data)))
{
	htm<-data$URL[j]							#reading the URL
	link<-readLines(htm)
	tables<- readHTMLTable(link,stringsAsFactors = FALSE)		#taking the tables from web
	tables <- list.clean(tables, fun = is.null, recursive = FALSE)	#cleaning the table for NULL table
	count=0
	l=length(tables)							#finding the no of tables in web
	if(l==0)
	{
	data2<-rbindlist(list(data2, data[j,]), fill = TRUE)	#continue the loop if there is no tables in the web page
	next
	}
	for(i in seq(1:l))							#looping around the tables
	{
	 table<-tables[[i]]							# eleminating the NULL error from table
	 if(any(grepl("Credit Default Swap",table,fixed=TRUE)))		# searching for the key in the table
	 {
	 if(table[1,1]!="Credit Default Swap")			# if there is any merged table for example 10th link
	{
	table<-table[(match("Credit Default Swap",table[,1])-1):nrow(table),]
	}
	 tab<- na.omit(table)							#eleminating Null from table
	 tab<-tab[!sapply(tab, function(x) all(x == ""))]			#eleminating Null columns from table
	 tab[1,1]<-"CDS Text"
	 dat<-t(tab[1:2,1:4])							
	dat[4,2]<-gsub("[[:space:]]", "", dat[4,2])			#working for depreciation  if any
	 dat[4,2]<-gsub("\\$\\(","-$",dat[4,2])				
	 dat[4,2]<-gsub("\\)","",dat[4,2])
	 dat<-as.data.frame(dat)				
	 names(dat) <- c("Attributes", "Values")
	 da1<-cbind(data[j,],dat)							# binding the table
	 count=count+1
	 data2<-as.data.frame(rbindlist(list(data2, da1), fill = TRUE))
	 }
	 }
	 if(count==0)
	 data2<-as.data.frame(rbindlist(list(data2, data[j,]), fill = TRUE)) #if there is no keyword found
}
write.csv(data2,"Phase1.csv",row.names=FALSE)			#writing the data on specific location