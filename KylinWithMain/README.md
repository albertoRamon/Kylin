# BI Tools and Apache Kylin

**Date:** September 2016

**Author:** Ramón Portolés, Alberto &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ![alt text](./Images/00.png)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [Linkedin](https://www.linkedin.com/in/alberto-ramon-portoles-a02b523b "My Linkedin") 

<p align="center">
  <img src=./Images/01.png />
</p>

&nbsp;
&nbsp;
### Intro: Kylin Project
[Apache Kylin](http://kylin.apache.org/) is a powerful software which enables Extrem OLAP cubes on Hadoop system, with lineal scalability and sub-second response time over TB of data

Mainly developed by [eBay](http://www.ebay.com/) and [Kyligence.io](http://kyligence.io/?lang=en) teams

Unfortunately is  little known, perhaps some causes can be:

+ Few documentation: some nice features are undocumented, onlydevelopers know how to use them 
+ It is developed / used by big companies with many technical and human resources
+ The access to data, is using a integrate UI Kylin or ODBC / API Rest, too complex for most of users or PoCs

&nbsp;
### Intro: Integration Study with BI
During two months (July & August 2016) I tried to connect kylin with most popular BI Tools, sometimes has been successful others .... it hasn't

Officially the Kylin ODBC Driver only has been tested with [Tableau Software](http://www.tableau.com/)

We evaluate two aspect: 
+ Connectivity to import data
+ Integration of this data with different features of this BI Tool

For our test use : Use [Kylin v1.5.2](http://kylin.apache.org/download/) (on docker) [Kylin ODBC v1.5](http://kylin.apache.org/docs15/tutorial/odbc.html)

&nbsp;
### Resume Table
Soft | Data Import | Data Integration | Detailed Manual | Version | License
--- | --- | --- | --- | --- | ---
[Tableau Desktop](http://www.tableau.com/products/desktop/download) | ![alt text](./Images/S3.png) | ![alt text](./Images/S3.png) | [GitGub](https://github.com/albertoRamon/Kylin/tree/master/KylinWithTableau) | v9.3.3 | Free
[Apache HUE](http://gethue.com/) | ![alt text](./Images/S3.png) | ![alt text](./Images/S1.png) | [GitGub](https://github.com/albertoRamon/Kylin/tree/master/KylinWithHue) | v3.10 | GPL 
[Qlik Desktop](http://www.qlik.com/us/products/qlik-sense/desktop) | ![alt text](./Images/S3.png) | ![alt text](./Images/S2.png) | [GitGub](https://github.com/albertoRamon/Kylin/tree/master/KylinWithQlik) | v3.0.2.0 | Free
[Kylin Carabel](https://github.com/rocky1001/caravel) | ![alt text](./Images/S0.png) | ![alt text](./Images/S0.png) | Internal* | v0.91 | GPL
[Sisense](https://www.sisense.com/) | ![alt text](./Images/S0.png) | ![alt text](./Images/S0.png) | Internal* | v6.4.1 | Demo
[Microsoft PowerBI](https://powerbi.microsoft.com/en-us/) | ![alt text](./Images/S0.png) | ![alt text](./Images/S0.png) | N.A | V2.38.4491 | Free


**Internal***:  Despite efforts, any remarkable result ![alt text](./Images/02.png) , But if you are interested I can share them with you

**License:**
+ GPL: Full features are free , code free
+ Free: With no code, but for free. 
+ Demo: Limited usage to certain period of time

&nbsp;
## Tableau
[View full Report](https://github.com/albertoRamon/Kylin/tree/master/KylinWithTableau)

**Resume:**
+ Some warning importing metadata but no issues when it is done.
+ The data integration is complete

&nbsp;
## Apache Hue
[View full Report](https://github.com/albertoRamon/Kylin/tree/master/KylinWithHue)

**Resume:**
+ Some issues and code changes must be made before compiling (see steps in manual)
+ View / Import meta-data is not available, more changes in code are needed(exits GIRA)
+ Only 1000 rows  can be Imported (exits GIRA)
+ Isn’t compatible with Dashboards (In Road-map for v4)
+ It’s a dynamic and important open source project, in next versions > 3.11 some bugs will be fixed

&nbsp;
## Qlik Desktop
[View full Report](https://github.com/albertoRamon/Kylin/tree/master/KylinWithQlik)

**Resume:**
+ Because there isn’t an official connector, you must write “load script”, it’s easy and works fine (see instructions)
+ This type of data have some limits:
  + You can't see the data preview
  + The associations (between tables are automatically made), you can’t change. This means if they aren’t correct, your results will be worng
+ [Technical Support](https://community.qlik.com/thread/232345)

&nbsp;
## Kylin Carabel
[Caravel](https://github.com/airbnb/caravel) is a UI for data exploration, developed by [Airbnb](https://www.airbnb.com/),  that uses  [Druid](http://druid.io/), as database
[Rocky Qi](https://github.com/rocky1001?tab=overview&from=2016-08-01&to=2016-08-31&utf8=%E2%9C%93) (thanks, for the suggestions) creates a fork [Kylin – Caravel](https://github.com/rocky1001/caravel), to support Kylin as database 

After 2 weeks of running test, (there is a bug in the internal metadata database) and previous branch didn't work on Ubuntu (there is some problems with this SO) and Centos… I desisted (sorry)

I will retry in the future / next version.  Its a good candidate for docker  (and makes life easier for others) (I like docker !!!)

&nbsp;
## Sisense
The answer of [technical support](https://support.sisense.com/requests/31921) of Sisense was that is compatible with Kylin

But, after contact with technical support, and some emails: it didn't work and there is no manual that could explain how to configure it to make work

You can see [this video](https://www.youtube.com/watch?v=BlDNKiIkdeo)

&nbsp;
## Microsoft PowerBI Desktop
I tried to import data using their automatic mode, and writing select queries. In the best case, I could see the pre-view of data before an import. But the import never worked

In logs, I saw some data convesion errors / overflows

You can see [this video](https://www.youtube.com/watch?v=v9of5N3TcTw)

[Kylin MailList](hhttp://mail-archives.apache.org/mod_mbox/kylin-user/201609.mbox/%3CCAF7etT%3DwSW1KqVqooYuYTvbKyx3njDH2E5wFSwQGie6jDVQm9g%40mail.gmail.com%3E)

&nbsp;
&nbsp;
## Others
Other tools that nowadays, can’t work with Apache Kylin (need changes in code, doesn’t support SQL, doesn’t support ODBC sources, .... )

&nbsp;
### [Kibi](https://siren.solutions/kibi/) / [Kibana](https://www.elastic.co/products/kibana)
From: *Giovanni Tummarello* (thanks, for the info)

*“Kibi dashboard **DO NOT support SQL or JDBC** a Kibi datasource is only used for special filters or certain other operations, check the documentation. We will likely support it in the future though.
saying this so that you dont waste your time.. you will not be able to see anything now with Kibi if you dont load things in ES also”*

### [Ploty](https://plot.ly/)
From: *Chris Parmer* (thanks, for the info)

*“Thanks for reaching out! **We haven't added this yet**. Do you use Apache Kylin at your work? We are going to be adding spark and redshift next before we get to something like Kylin.”*

&nbsp;
## ToDo:
Test and doc the integration of Kylin with [Saiku](http://www.meteorite.bi/products/saiku) and [Zeppelin](https://github.com/apache/zeppelin/tree/master/kylin)

&nbsp;
&nbsp;

**For any suggestions, feel free to contact me**

**Thanks, Alberto**
