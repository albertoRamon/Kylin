# !! Moved to [Official Doc](http://kylin.apache.org/docs16/) /  [Connect from SQuirreL](http://kylin.apache.org/docs16/tutorial/squirrel.html) !!
# Use SQuirreL with Apache Kylin

**Date:** October 2016

**Update:** Dicember 2016

**Author:** Ramón Portolés, Alberto  ![alt text](./Images/00.png)  [Linkedin](https://www.linkedin.com/in/alberto-ramon-portoles-a02b523b "My Linkedin") 

&nbsp;
&nbsp;
### Intro
SquirreL SQL is a multi platform Universal SQL Client (GNU License)
You can use it to access HBase + Phoenix and Hive

&nbsp;
### Used Software
* [Kylin v1.5.2](http://kylin.apache.org/download/) & ODBC 1.5
*  Update Dic 2016: Kylin 1.6.0 & ODBC 1.6 Works OK
* [SquirreL SQL v3.7.1](http://www.squirrelsql.org/)

&nbsp;
## Pre-requisites
* We need to find the JAR Class for the JDBC Connector

  From Kylin Download, Choose Binary and the **correct version of Kylin and HBase**
  
	Download & Unpack:  in **./lib**: 
<p align="center">
  <img src=./Images/01.png />
</p>

* We need an instance of Kylin, with a cube: Quick Start with Sample Cube, will be enough

  You can check: 
<p align="center">
  <img src=./Images/02.png />
</p>

* [Dowload and install SquirreL](http://www.squirrelsql.org/#installation), you will need Java

&nbsp;
## Add Kylin Driver
On left menu: ![alt text](./Images/03.png) >![alt text](./Images/04.png)  > ![alt text](./Images/05.png)  > ![alt text](./Images/06.png)

And locale your JAR: ![alt text](./Images/07.png)

Configure this parameters:

* Put a name: ![alt text](./Images/08.png)
* Example URL ![alt text](./Images/09.png)

  jdbc:kylin://172.17.0.2:7070/learn_kylin
* Put Class Name: ![alt text](./Images/10.png)
	TIP:  If auto complete not work, type you:  org.apache.kylin.jdbc.Driver 
	
Check in your Driver List: ![alt text](./Images/11.png)

&nbsp;
## Add Aliases
On left menu: ![alt text](./Images/12.png)  > ![alt text](./Images/13.png) : (Login pass by default: ADMIN / KYLIN)
<p align="center">
  <img src=./Images/14.png />
</p>

And automatically launch conection:
<p align="center">
  <img src=./Images/15.png />
</p>

&nbsp;
## Connect and Execute
The startup window when you are connect:
<p align="center">
  <img src=./Images/16.png />
</p>


Choose Tab:   and write your querie  (whe use Kylin’s example cube):
<p align="center">
  <img src=./Images/17.png />
</p>

```
select part_dt, sum(price) as total_selled, count(distinct seller_id) as sellers 
from kylin_sales group by part_dt 
order by part_dt
```

Execute With: ![alt text](./Images/18.png) 
<p align="center">
  <img src=./Images/19.png />
</p>

And it’s works,OK ![alt text](./Images/20.png) 

&nbsp;
## Extra: Some tips:
SquirreL isn’t the most stable SQL Client, but its very flexible and get you a lot of info

I use it for PoC and try to solve / check connectivity problems

List of  Tables: 
<p align="center">
  <img src=./Images/21.png />
</p>

&nbsp;

List of Columns of table:
<p align="center">
  <img src=./Images/22.png />
</p>

&nbsp;

List of column of Querie:
<p align="center">
  <img src=./Images/23.png />
</p>

&nbsp;

Export the result of queries:
<p align="center">
  <img src=./Images/24.png />
</p>

&nbsp;

 Info about time query execution:
<p align="center">
  <img src=./Images/25.png />
</p>

&nbsp;
&nbsp;

**For any suggestions, feel free to contact me**

**Thanks, Alberto**

