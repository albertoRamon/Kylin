

#IMPORT
import json
import re
import gzip						#to open gz source
import bz2						#to create bz2
bz2c = bz2.BZ2Compressor()

#CONFIGURATION PARAMETERS
InputFile='DataDownloaded/metadata.json.gz'
OutputFile='DataProcesed/metadata.csv.bz2'

PrintInfo=10000					#Print progress each n rows
MaxRows=10000009999				#Max Rows to process

#INTERNAL PARAMETERS
Cnt=0							#For login pourpose
CntError=0						#For login pourpose
CompressData=''

def parse(path):
	g = gzip.open(path, 'r') 
	for l in g: 
		yield json.dumps(eval(l)) 

for line in parse(InputFile):
	try:
		json_data = json.loads(line)
	except ValueError, e:
		CntError+=1
		continue
		
	#Fields to read
	#  Protected if the label don't exist in JSON
	#  Protected if the strings have ", tabs, retuns, new line , "," (because is the separator of CSV)
	#  Protected if the strings have more than 225 chars, because is the leng for defect
	#  Protected if the array is empty
	if 'asin' in json_data: asin = json_data['asin']
	else: asin='NULL'

	#if 'title' in json_data: title = json_data['title'].replace ("\"","").replace(",","")
	if 'title' in json_data: title = re.sub('[^a-zA-Z0-9 \.]', '',json_data['title'])[:220]
	else: title='NULL'

	if 'salesRank' in json_data and len(json_data['salesRank'].keys())>0 : salesRank = json_data['salesRank'].keys()[0].replace ("\"","")  #Only read the fisrt
	else: salesRank='NULL'

	if 'brand' in json_data: brand = json_data['brand'].replace ("\"","")
	else: brand='NULL'

	if 'categories'in json_data and len(json_data['categories'][0][0])>0: categories = json_data['categories'][0][0].replace ("\"","")
	else: categories='NULL'

	Cnt+=1
	if Cnt%PrintInfo==0: print ('Progress:  '+str(Cnt) +'  Errors: ' + str(CntError))
	RawData ="\""+ asin + "\",\"" + title + "\",\"" + salesRank + "\",\"" + brand + "\",\"" + categories+"\"" +"\n"
	CompressData += bz2c.compress(RawData)
	#print (RawData)
	if (Cnt >= MaxRows): break

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