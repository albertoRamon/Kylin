
#IMPORT
import re
import csv
import bz2						#to create bz2
bz2c = bz2.BZ2Compressor()

#CONFIGURATION PARAMETERS
InputFile='DataDownloaded/item_dedup.csv'
OutputFile='DataProcesed/item_dedup.csv.bz2'

CharSeparator=','				#Field separator
PrintInfo=100000				#Print progress each n rows
MaxRows=10000009999					#Max Rows to process

#INTERNAL PARAMETERS
Cnt=0							#For login pourpose
CntError=0						#For login pourpose
CompressData=''



with open(InputFile, 'rb') as csvfile:
	spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')
	for row in spamreader:     #row is a list
		if len (row) <> 4:
			CntError+=1
			continue
			
		UserId=row[0]
		ASIN=row[1]
		Rating=int(float(row[2]))
		Time=row[3]
		RawData = "\"" + UserId + "\",\"" + ASIN + "\","+ str(Rating) + "," + str(Time) +"\n"
		CompressData += bz2c.compress(RawData)
		#print (RawData)
		Cnt +=1
		if Cnt%PrintInfo==0: print ('Progress:  '+str(Cnt) +'  Errors: ' + str(CntError))
		if (Cnt>= MaxRows): break
		
CompressData+=bz2c.flush()
newFile = open (OutputFile,"w")
newFile.write(CompressData)
newFile.close()

print ('')	
print ('Input File:        '+str(InputFile))
print ('Output File:       '+str(OutputFile))
print ('Register Procesed: '+str(Cnt))
print ('Register Ommited:  '+str(CntError))
if Cnt >= MaxRows:print ('Exited by max number of rows')