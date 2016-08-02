# Use Tableau with Apache Kylin
**Date:** August 2016

**Author:** Ramón Portolés, Alberto  ![alt text](./Images/00.png)   [Linkedin](https://www.linkedin.com/in/alberto-ramon-portoles-a02b523b "My Linkedin")  		

## Intro
We can use [Quick Start with Sample Cube ](http://kylin.apache.org/docs15/tutorial/kylin_sample.html "Build Instructions") of Kylin Project to make an example of integration with Tableau Software

<p align="center">
  <img src=./Images/50.png />
</p>

&nbsp;
&nbsp;
## Pre-requisites
The First, you need Build Kylin Cube: [Quick Start with Sample Cube](http://kylin.apache.org/docs15/tutorial/kylin_sample.html "Build Instructions"): With Step 5, you can check the result cube Executing:

&nbsp;&nbsp;&nbsp;*select part_dt, sum(price) as total_selled, count(distinct seller_id) as sellers from kylin_sales group by part_dt order by part_dt*


<p align="center">
  <img src=./Images/48.png />
</p>
&nbsp;

Second, Install [Tableau Desktop 9.3.3](http://www.tableau.com/products/desktop/download "Download") On Windows

&nbsp;
&nbsp;
## Used Software
+ [Kylin: 1.5.2](http://kylin.apache.org/download/ "Download")
+ [Kylin ODBC 1.5](http://kylin.apache.org/docs15/tutorial/odbc.html "Download") (Don’t use v1.3, don’t work)
+ [Tableau Desktop 9.3.3](http://www.tableau.com/products/desktop/download "Download")

&nbsp;
&nbsp;
## Create Connection
1. [Install Kylin ODBC](http://kylin.apache.org/docs15/tutorial/odbc.html "Install")

2. Add DNS System in Windows
<p align="center">
  <img src=./Images/01.png />
</p>

3. And configure: User-name /Password: **ADMIN / KYLIN**
<p align="center">
  <img src=./Images/02.png />
</p>

4. Click Connect and Choose the project
<p align="center">
  <img src=./Images/03.png />
</p>

5. Click on “Done”

6. Download and install Tableu Desktop  and launch it

7. ![alt text](./Images/04.png) > ![alt text](./Images/05.png) > ![alt text](./Images/06.png)

8. ![alt text](./Images/07.png) > ![alt text](./Images/08.png)

9. Complete details connections (ADMIN /KYLIN), click done, click OK:
<p align="center">
  <img src=./Images/09.png />
</p>

10. Click on ![alt text](./Images/10.png) > ![alt text](./Images/11.png) > ![alt text](./Images/12.png) (In **magnifying glass**)

 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The result must be, three new tables (on left panel):
<p align="center">
  <img src=./Images/13.png />
</p>

 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NOTE: Sometimes it doesn’t work fine,, Solution: close and open Tableau  :)

11. Add this tables to Tableau: Drag and Drop to ![alt text](./Images/14.png)

* First “Kylin_sales” (Fact Table) and second “Kylin_Cal_DT” (Dimension table)
<p align="center">
  <img src=./Images/15.png />
</p>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; And Join Relation:
<p align="center">
  <img src=./Images/16.png />
</p>

* Now the same with “Kylin_Category_Groupings”
<p align="center">
  <img src=./Images/17.png />
</p>

* The result must be:
<p align="center">
  <img src=./Images/18.png />
</p>


* Now if you click:![alt text](./Images/19.png) , you must see data table:
<p align="center">
  <img src=./Images/20.png />
</p>

&nbsp;
&nbsp;
## Intro to Sheet Elements
Go to Sheet 1: ![alt text](./Images/21.png)
You must see the Dimensions in left panel
<p align="center">
  <img src=./Images/22.png />
</p>

And measures:
<p align="center">
  <img src=./Images/23.png />
</p>

&nbsp;
&nbsp;
## Our First WorkSheet
Drag and Drop “Cal_Dt” and “Price” like in picture:
<p align="center">
  <img src=./Images/24.png />
</p>

You can expand to Quarter and Months: Click on “Plus” of year: ![alt text](./Images/25.png)
<p align="center">
  <img src=./Images/26.png />
</p>

We can add sub-totals  by category: Drag and Drop “Meta Categ Name” to “Color”
<p align="center">
  <img src=./Images/27.png />
</p>

The result must be similar to:
<p align="center">
  <img src=./Images/28.png />
</p>

&nbsp;
&nbsp;
## Second Worksheet
Create new Worksheet ![alt text](./Images/29.png)
Drag and Drop:
<p align="center">
  <img src=./Images/30.png />
</p>

After than we can see the relations between  “Meta Categ Name”,  "L2" and "L3":
<p align="center">
  <img src=./Images/31.png />
</p>

Delete 3 the three fields in “Rows” and generate a hierarchy:  using Dimensions Menu (Left side) Drag and Drop “Lvl2” over “Meta Categ Name” and after D & Drop “Lvl3”, the result must be:
<p align="center">
  <img src=./Images/32.png />
</p>

Drag and Drop the New hierarchy on “Rows” and expands
<p align="center">
  <img src=./Images/33.png />
</p>

Change the diagram type to table: ![alt text](./Images/34.png)

Drag and Drop “Price” to Rows, and see total at right of table:
<p align="center">
  <img src=./Images/35.png />
</p>

Now you can change the graph type:![alt text](./Images/36.png)
<p align="center">
  <img src=./Images/37.png />
</p>


&nbsp;
&nbsp;
## Create Dashboard
Create New Dashboard ![alt text](./Images/38.png)

Drag and Drop WorkSheet_1 and WorkSheet_2
<p align="center">
  <img src=./Images/39.png />
</p>


## Add filter to dashboard
1º Add Filter to Worksheet_1 : ![alt text](./Images/40.png)

2º Configure the filter like “All Using this Data Source” ![alt text](./Images/41.png)

3º Then check the Worksheet_2 and we will see a new filter has been append: ![alt text](./Images/42.png)

4º Add filter to dashboard: Select a Worksheet on Dashboard, and right- click on upper edge ![alt text](./Images/43.png)

Filter > “Cal Dt”
<p align="center">
  <img src=./Images/44.png />
</p>
&nbsp;

After that  a new right panel will appear: ![alt text](./Images/45.png) ,this filter will be affect on all Dashboard’s Worksheet

Furthermore, you can filter by date, clicking in month, on upper worksheet ![alt text](./Images/46.png)

&nbsp;
Or, you can filter by category, clicking in category too ![alt text](./Images/47.png)

&nbsp;
&nbsp;
## Final Result:
<p align="center">
  <img src=./Images/49.png />
</p>

&nbsp;
&nbsp;

**__For any suggestions, feel free to contact me__**

**__Thanks, Alberto__**




