# Analyze Amazon Reviews with Apache Kylin


### Abstract
On [_Playing with 80 Million Amazon Product Review Ratings Using Apache Spark_](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet), Max Woolf, Uses Apache Spark with Python and R to analyze an Amazon Dataset. 

We will use [Apache Kylin](http://kylin.apache.org/) and [Tableau](https://www.tableau.com/) to generate reports ad-hoc easily and see the response time of them 


### Required software & hardware
Software used: 
* Kylin 1.6 or superior, [download](http://kylin.apache.org/download/)
* BI Tool, you can choose your own favorite tool, in this case Tableau Desktop is used, [download](https://www.tableau.com/products/desktop/download)
* Optional, If you don't have access to a Hadoop Cluster, Docker is a good solution to mount a Hadoop system (I use it and works without problems), [download](https://www.docker.com/community-edition)

To clone this repository: 
```
git clone https://github.com/albertoRamon/Kylin.git
```

### About Amazon Ratings Dataset
[Download Page](http://jmcauley.ucsd.edu/data/amazon/)
This dataset provides two types of files:
* Review files: After a puchase the customer has the posiblity to evaluate the product, from 1 to 5 starts and write comment
* Metadata file: It's a full description of one product: Name, Brand, Picture, category....

These files are relationed by _asin_ unique identifier for each Amazon Product

We use these two files:
* Metadata: Is a compressed json in gz with 9.4 Million products (size: 3.4 GB / 10.5 GB)
* Ratings only: Is an uncompressed CSV file with 82.6 Million of evaluations

Download it and store as is (without descompress) in _DataDownloaded_ folder, as is:
<p align="center">
  <img src=./Images/01.png />
</p>

**Note1**: To download some big files you will need write an email for a request

**Note2**: Ratings only file can be substituted for one of smaller files from "subset" section

### Prepare Dataset
We need prepare the two original files to be ingested into Hive tables, to do this execute the python scripts
```
python processItem.py
puthon processMetadata.py
```
As result you will have two new files in the folder _DataProcesed_, as is:
<p align="center">
  <img src=./Images/02.png />
</p>

### Copy data to Hive and create tables 

