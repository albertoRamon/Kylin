-# Connect from Tableau step by step
**Date:** August 2016

**Updated:** March 2017

**Author:** Ramón Portolés, Alberto  ![alt text](./Images/00.png)   [Linkedin](https://www.linkedin.com/in/alberto-ramon-portoles-a02b523b "My Linkedin")  		

### Intro
[Quick Start with Sample Cube ](http://kylin.apache.org/docs15/tutorial/kylin_sample.html "Build Instructions") can be used with Kylin Project to make an example of integration with Tableau Software

<p align="center">
  <img src=./Images/50.png />
</p>

&nbsp;
&nbsp;
### Pre-requisites
First, you need to Build Kylin Cube: [Quick Start with Sample Cube](http://kylin.apache.org/docs15/tutorial/kylin_sample.html "Build Instructions") and check the result cube executing:

    select part_dt, sum(price) as total_selled, count(distinct seller_id) as sellers from kylin_sales group by part_dt order by part_dt*

<p align="center">
  <img src=./Images/48.png />
</p>
&nbsp;

Second, Install [Tableau Desktop](http://www.tableau.com/products/desktop/download "Download") on Windows

&nbsp;
&nbsp;
### Used Software
+ [Kylin: 1.5.2](http://kylin.apache.org/download/ "Download")
+ [Kylin ODBC 1.5](http://kylin.apache.org/docs15/tutorial/odbc.html "Download") (Don’t use v1.3, don’t work)
+ [Tableau Desktop 9.x or 10.x](http://www.tableau.com/products/desktop/download "Download") Tableau 9.3.3 has beeen tested with Kylin 1.5.x y Tableau 10.1.1 with Kylin 1.6.x

If you use the twb files from my GitHub, you will be prompted to convert to a new version (and you will not able to open this file with previous versions)

&nbsp;
&nbsp;
### Create Connection
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

The result should be three new tables (on left panel):
<p align="center">
  <img src=./Images/13.png />
</p>

NOTE: Sometimes it doesn’t work correctly, Solution: close and open Tableau  :)

11. Add these tables to Tableau: Drag and Drop to ![alt text](./Images/14.png)

* First “Kylin_sales” (Fact Table) and second “Kylin_Cal_DT” (Dimension table)
<p align="center">
  <img src=./Images/15.png />
</p>

And Join Relation:
<p align="center">
  <img src=./Images/16.png />
</p>

* Now do the same with “Kylin_Category_Groupings”
<p align="center">
  <img src=./Images/17.png />
</p>

* The result should be:
<p align="center">
  <img src=./Images/18.png />
</p>


* Now if you click:![alt text](./Images/19.png) , you should see this data table:
<p align="center">
  <img src=./Images/20.png />
</p>

&nbsp;
&nbsp;
### Intro to Sheet Elements
Go to Sheet 1: ![alt text](./Images/21.png)
You should see the Dimensions in left panel
<p align="center">
  <img src=./Images/22.png />
</p>

And measures:
<p align="center">
  <img src=./Images/23.png />
</p>

&nbsp;
&nbsp;
### First WorkSheet
Drag and Drop “Cal_Dt” and “Price” like in picture:
<p align="center">
  <img src=./Images/24.png />
</p>

To expand to Quarter and Months: Click on “Plus” of year: ![alt text](./Images/25.png)
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
### Second Worksheet
Create new Worksheet ![alt text](./Images/29.png)

Drag and Drop, and configure if us follows:
<p align="center">
  <img src=./Images/30.png />
</p>

Then we can see the relations between  “Meta Categ Name”,  "L2" and "L3":
<p align="center">
  <img src=./Images/31.png />
</p>

Delete 3 the three fields in “Rows” and generate a hierarchy using Dimensions Menu (on the Left) Drag and Drop “Lvl2” over “Meta Categ Name” and after D & Drop “Lvl3”, the new result must be:
<p align="center">
  <img src=./Images/32.png />
</p>

Drag and Drop the New hierarchy on “Rows” and expand it
<p align="center">
  <img src=./Images/33.png />
</p>

Change the diagram type to table: ![alt text](./Images/34.png)

Drag and Drop “Price” to Rows, and watch the total price on th right hand side of table:
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

Drag and Drop WorkSheet_1 and WorkSheet_2 to the new dashboard
<p align="center">
  <img src=./Images/39.png />
</p>


## Add filter to dashboard
1º Add Filter to Worksheet_1 : ![alt text](./Images/40.png)

2º Configure the filter with using “All Using this Data Source” ![alt text](./Images/41.png)

3º Then check the Worksheet_2 and we will see that a new filter has been append: ![alt text](./Images/42.png)

4º Add the filter to the dashboard: Select a Worksheet on the Dashboard, and right- click on upper edge ![alt text](./Images/43.png)

Filter > “Cal Dt”
<p align="center">
  <img src=./Images/44.png />
</p>
&nbsp;

After that  a new  panel will appear on the right: ![alt text](./Images/45.png) ,this filter will affect  all the Dashboard’s Worksheets

Furthermore, you can filter by date clicking on month, in the upper worksheet ![alt text](./Images/46.png)

&nbsp;
Or, you can filter by category, clicking in category: ![alt text](./Images/47.png)

&nbsp;
&nbsp;
## Final Result:
<p align="center">
  <img src=./Images/49.png />
</p>

Tableau Files: [Full.twb](https://github.com/albertoRamon/Kylin/blob/master/KylinWithTableau/Full.twb "Download Full Example") &nbsp;&nbsp;&nbsp;
 [OnlyConnection.twb](https://github.com/albertoRamon/Kylin/blob/master/KylinWithTableau/OnlyConnection.twb "Download with only Connection")

&nbsp;
&nbsp;

**__For any suggestions, feel free to contact me__**

**__Thanks, Alberto__**




