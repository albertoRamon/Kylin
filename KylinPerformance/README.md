# Example of Tuning Cube I/II
**Date:** Dic 2016

**Author:** Ramón Portolés, Alberto  ![alt text](./Images/00.png) &nbsp; &nbsp; &nbsp; &nbsp;  [Linkedin](https://www.linkedin.com/in/alberto-ramon-portoles-a02b523b "My Linkedin")  		

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Thanks to ShaoFeng Shi for help*

&nbsp;
&nbsp;

We can try to optimize a very simple Cube, with 1 Dim and 1 Fact table (Date Dimension)
<p align="center">
  <img src=./Images/01.png />
</p>

Our Base line is:

* One Measure: Balance, we calculate always Max, Min and Count
* All Dim_date (10 items) will be used as dimensions 
* Input is a Hive CSV external table 
* Output is a Cube in HBase with out compression 

With this configuration, the results are: 13 min to build a cube of 20 Mb  (Cube_01)

## Cube_02
Our first improve will be use Joint and hierarchy on Dimensions to reduce the carnality

We can put together all ID and Text of: Month, Week, Weekday and Quarter
<p align="center">
  <img src=./Images/02.png />
</p>
	
Define Id_date and year like Hierarchy

The size down to 0.72 and time to 5 min

&nbsp;

[Kylin 2149](https://issues.apache.org/jira/browse/KYLIN-2149), ideally, we can define define also these Hierarchies:
* Id_weekday > Id_date
* Id_Month > Id_date
* Id_Quarter > Id_date
* Id_week > Id_date

But for now, isn’t possible use Joint and hierarchy together in one Dim   :(

&nbsp;
## Cube_03
Now we can try compress HBase Cube with Snappy:

![alt text](./Images/03.png)

&nbsp;
## Cube_04
Now we can try compress HBase Cube with gzip:

![alt text](./Images/04.png)

&nbsp;

The results of compression output are:

![alt text](./Images/05.png)

The difference between Snappy and gzip in time is very few 1% but in size is 18%

&nbsp;
## Cube_05
Now the time distribution is like this:
<p align="center">
  <img src=./Images/06.png />
</p>

We can group detailed times in groups by concepts :
<p align="center">
  <img src=./Images/07.png />
</p>
We can see the **67%** is used to build / process flat table respect 30% to build cube
We are losing a lot of time in first steps !!

&nbsp;

We can try to use ORC Format and compression on Hive (Snappy):
<p align="center">
  <img src=./Images/08.png />
</p>

The time in three first steps (Flat Table) has been improved to the half  :)

&nbsp;
## Cube_06: Fail
If we see the distribution of rows:

Table | Rows
--- | --- 
Fact Table | 3.900.00 
Dim Date | 2.100 

And see the query to build the flat table: (The idea is)
```sql
SELECT
,DIM_DATE.X
,DIM_DATE.y
,FACT_POSICIONES.BALANCE
FROM  FACT_POSICIONES  INNER JOIN DIM_DATE 
	ON  ID_FECHA = .ID_FECHA
WHERE (ID_DATE >= '2016-12-08' AND ID_DATE < '2016-12-23')
```

The problem is, Hive in only using 1 Map to create Flat Table. Then lets go to change this undesirable behavior. Our solution is partition DIM and FACT by same columns
* Option 1: Use id_date as partition column on Hive table. This have a big problem: the Hive metastore is meant for few hundred of partitions not thousand (Hive 9452 there is an idea to solve this isn’t in progress)
* Option 2:Generate a new column for this purpose like monthslot.
<p align="center">
  <img src=./Images/09.png />
</p>

The same column will be add to dim and fact tables

Now the data model need be cached, add this new condition to join 
<p align="center">
  <img src=./Images/10.png />
</p>
	
The new query to generate flat table will be similar to:
```sql
SELECT *
	FROM  FACT_POSICIONES  **INNER JOIN** DIM_DATE 
		ON  ID_FECHA = .ID_FECHA    AND  MONTHSLOT=MONTHSLOT
```
And launch the build of new cube with this data model

But The performance has worsened  :( . I tried several test without solution
<p align="center">
  <img src=./Images/11.png />
</p>

The problem is didn’t use partitions to generate several Mappers
<p align="center">
  <img src=./Images/12.png />
</p>
	
&nbsp;
## The Final results
<p align="center">
  <img src=./Images/13.png />
</p>

&nbsp;

&nbsp;


# Example of Tuning Cube II
**Date:**  Dicember 2016

**Author:** Ramón Portolés, Alberto  ![alt text](./Images/00.png)   [Linkedin](https://www.linkedin.com/in/alberto-ramon-portoles-a02b523b "My Linkedin")  		
 		
&nbsp;
## Tuning of M-R Map-Reduce
After tuning of M-R Map-Reduce
After tuning of cube: 

(See KylinPerformance_I)
* Hive Input tables compressed
* HBase Output compressed
* Apply techniques of reduction of cardinality (Joint, Derived, Hierarchy and Mandatory)
* Personalize Dim encoder for each Dim and Choose best order of Dim in Row Key

&nbsp;

Now we have three types of cubes:
* Cubes with low cardinality in their dimensions
* Cubes with high cardinality in their dimensions
* The third type, ultra high cardinality (UHC) which is outside the scope of this article

&nbsp;
## Cubes with low cardinality Dimensions:
In our example:
* Fact table 4Millons of rows
* Dim1 2K & Dim2 12K of rows

Out Time Chart must be similar to this:
<p align="center">
  <img src=./Images/14.png />
</p>


If we make a group by concept:
<p align="center">
  <img src=./Images/15.png />
</p>

We can see the 67% of time is used on Flat Table (Steps 1,2,3)

&nbsp;
### Attempt 1:
How can try to reduce the time in these steps?

You can see the SQL Hive of these steps on ![alt text](./Images/16.png)  > ![alt text](./Images/17.png)
<p align="center">
  <img src=./Images/18.png />
</p>
We can see:

* Uses external Tables of Hive
* Uses Sequencefile as storage format

We can try to use other columnar formats:
<p align="center">
  <img src=./Images/19.png />
</p>

* ORC
* ORC compressed with Snappy

But the result are worst than Sequence file …

See comments about this from [Shaofengshi in MailList](http://apache-kylin.74782.x6.nabble.com/Kylin-Performance-td6713.html#a6767)

&nbsp;
### Attempt2:
The second strep (redistribute Flat Hive table)
<p align="center">
  <img src=./Images/20.png />
</p>

Is a simple row count:
<p align="center">
  <img src=./Images/21.png />
</p>
We can think in some approx: If we don’t need accurate, we can make a count of fact table → this can be performed in parallel with Step 1 (and 99% of times will be accurate)

See comments about this from [Shaofengshi in MailList](http://apache-kylin.74782.x6.nabble.com/Kylin-Performance-td6713.html#a6767) , In future version ( [Kylin 2265](https://issues.apache.org/jira/browse/KYLIN-2165) v2.0) this steps will implemented using Hive table statistics

&nbsp;
## Cubes with high cardinality Dimensions:
<p align="center">
  <img src=./Images/22.png />
</p>
In this case the **72%** of time is used to Build Cube

This step is a MapReduce task, you can see the Sql Hive of these steps on ![alt text](./Images/23.png) > ![alt text](./Images/24.png) 

&nbsp;
### Attempt1:
How can improve the performance of Map – Reduce? The easy Way is increase the numbers of mappers and reduces (= Increase parallelism).
<p align="center">
  <img src=./Images/25.png />
</p>

**NOTE:** YARN / MapReduce have a lot parameters to configure and adapt to your system, we only will be focus on small part of them

(In my system I can assign to YARN Resources: 12 – 14 GB and 8 cores)

* yarn.nodemanager.resource.memory-mb = 15 GB
* yarn.scheduler.maximum-allocation-mb = 8 GB
* yarn.nodemanager.resource.cpu-vcores = 8 cores
With this config our max teorical grade of paralelist is 8 , but this have a problem: “Timed out after 3600 secs”
<p align="center">
  <img src=./Images/26.png />
</p>


The parameter mapreduce.task.timeout  (1 hour by default) define max time that Application Master (AM) can happen with out ACK of Yarn Container. Once past this time, AM kill the container and retry the same 4 times (with same result)

Where is the problem? Our problem is that I starter 4 mappers, but each mapper need more than 4 GB to finish

* The solution 1:  add more RAM to YARN 
* The solution 2:  add more Reduce the number to vCores
* The solution 3: You can play with max RAM to YARN by node  (yarn.nodemanager.resource.memory-mb) and min RAM to container (yarn.scheduler.minimum-allocation-mb). If you increase minimum RAM per container, YARN will reduce the numbers of maps
<p align="center">
  <img src=./Images/27.png />
</p>

In three cases the result are the same: reduce the level of parallelism ==> 
* Now we only start 3 mappers at same time, the fourth must be wait to free slot
* The three first mappers spread the ram, then they will have enough ram to finish the task

During a normal “Build Cube” step you must see similars messages on YARN log:
<p align="center">
  <img src=./Images/28.png />
</p>

If you don’t see periodically, perhaps you have a bottleneck in memory

&nbsp;
### Attempt2:
We can try to use differences aggregations groups to improve the query performance of some Dim very important or with high cardinality.

In our case we define 3 Aggregations Groups: 
1. “Normal cube”
2. Cube with Date Dim and Currency (as mandatory)
3. Cube with Date Dim and Carteras_Desc (as mandatory)
<p align="center">
  <img src=./Images/29.png />
</p>
<p align="center">
  <img src=./Images/30.png />
</p>
<p align="center">
  <img src=./Images/31.png />
</p>
	
	

Compare without / with AGGs:
<p align="center">
  <img src=./Images/32.png />
</p>

Now we uses 3% more of time to build the cube and 0.6% of space, but queries by currency or Carteras_Desc will be very faster



&nbsp;
&nbsp;

**__For any suggestions, feel free to contact me__**

**__Thanks, Alberto__**




