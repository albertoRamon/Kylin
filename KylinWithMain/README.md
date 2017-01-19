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
[Tableau Desktop](http://www.tableau.com/products/desktop/download) | ![alt text](./Images/S3.png) | ![alt text](./Images/S3.png) | [GitHub](https://github.com/albertoRamon/Kylin/tree/master/KylinWithTableau) | v9.3.3 | Free
[Apache HUE](http://gethue.com/) | ![alt text](./Images/S3.png) | ![alt text](./Images/S1.png) | [GitHub](https://github.com/albertoRamon/Kylin/tree/master/KylinWithHue) | v3.10 | GPL 
[Qlik Desktop](http://www.qlik.com/us/products/qlik-sense/desktop) | ![alt text](./Images/S3.png) | ![alt text](./Images/S2.png) | [GitHub](https://github.com/albertoRamon/Kylin/tree/master/KylinWithQlik) | v3.0.2.0 | Free
[SQuirreL](http://www.squirrelsql.org/)  | ![alt text](./Images/S3.png) | ![alt text](./Images/S3.png) | [GitHub](https://github.com/albertoRamon/Kylin/tree/master/KylinWithSQuirreL) | v3.7.1 | GPL
[Apache Zeppelin](https://zeppelin.apache.org/) | ![alt text](./Images/S3.png) | ![alt text](./Images/S3.png) | [External](http://zeppelin.apache.org/docs/0.7.0-SNAPSHOT/interpreter/kylin.html) | v0.7 | GPL
[Apache Flink](https://flink.apache.org/) | ![alt text](./Images/S3.png) | ![alt text](./Images/S3.png) | [GitHub](https://github.com/albertoRamon/Flink/tree/master/ReadKylinFromFlink) | v1.2 | GPL
[Kylin Caravel](https://github.com/rocky1001/caravel) | ![alt text](./Images/S0.png) | ![alt text](./Images/S0.png) | Internal* | v0.91 | GPL
[Sisense](https://www.sisense.com/) | ![alt text](./Images/S0.png) | ![alt text](./Images/S0.png) | Internal* | v6.4.1 | Demo
[Microsoft PowerBI](https://powerbi.microsoft.com/en-us/) | ![alt text](./Images/S0.png) | ![alt text](./Images/S0.png) | N.A | v2.38.4491 | Free
[Dundas BI](http://www.dundas.com/) | ![alt text](./Images/S0.png) | ![alt text](./Images/S0.png) | N.A | v3.0.2.100 | Demo
[Microsoft SSRS: Report Builder](https://technet.microsoft.com/en-us/library/ms159253(v=sql.105).aspx) | ![alt text](./Images/S0.png) | ![alt text](./Images/S0.png) | N.A | v2012 SP3 | Demo
[Microsoft SSRS: SSDT](https://msdn.microsoft.com/en-us/library/hh272686(v=vs.103).aspx) | ![alt text](./Images/S0.png) | ![alt text](./Images/S0.png) | N.A | v2012 SP3 | Demo


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
## SQuirreL (Unversal SQL Client)
[View full Report](https://github.com/albertoRamon/Kylin/tree/master/KylinWithSQuirreL)

The configuration is not very intuitive, but works very well and get us a lot of information about tables metadata

Indicated for PoC or Kylin UI alternative

Not use ODBC driver uses JDBC directly then:

* Good for performance and avoid ODBC problems
* The version of Kylin and JDBC must be the same (upgrade Kylin implies upgrade your Java lib)

&nbsp;
## Apache Zeppelin
[Apache Kylin Interpreter for Apache Zeppelin](http://zeppelin.apache.org/docs/0.7.0-SNAPSHOT/interpreter/kylin.html)

[Apache Zeppelin](https://zeppelin.apache.org/)  is Web notebook very useful for generate dynamic reports which integrate data from differents datasources (Hive, Spark, Kylin, Flink, PostgreSQL, HBase, .. )

You can found exaples in [ZeppelinHub](https://www.zeppelinhub.com/viewer) and [Hortonworks Zeppelin Gallery](https://github.com/hortonworks-gallery/zeppelin-notebooks)

&nbsp;
## Apache Flink
[View full Report](https://github.com/albertoRamon/Flink/tree/master/ReadKylinFromFlink)

[Apache Flink](https://flink.apache.org/)  is a Framework to process data in batch or streaming mode

Now we can read Kylin’s data from Apache Flink, Flink 1.2 or higger is recomended

&nbsp;
## Kylin Caravel
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

In logs, I saw some data convesion errors / overflows. You can see [this video](https://www.youtube.com/watch?v=v9of5N3TcTw)

The problem are some issues of ODBC connector :

* [KYLIN-2121](https://issues.apache.org/jira/browse/KYLIN-2121) v1.6.0 Bug  "Value was either too large or too small for an Int32" 
* [Kylin 2235](https://issues.apache.org/jira/browse/KYLIN-2235) vx.x Bug "array dimensions exceed supported ranges" 

&nbsp;
## Dundas BI
(Thanks to [Ariel Pohoryles](https://www.linkedin.com/in/ariel-pohoryles-88695622), of Dundas team)

Dundas BI, Was one of the first to do graphs with high visual quality

Microsoft purchased a license to use Dundas Chart on SQL Rerporting services 2008 and above

There is a demo for 45 days

Nowadays,  there is a bug reading metadata ( [Kylin 2274](https://issues.apache.org/jira/browse/KYLIN-2274), Afer review problem with Dudas Team sound like a problem with ODBC ( [explanation](https://issues.apache.org/jira/browse/KYLIN-2274?focusedCommentId=15747545&page=com.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel#comment-15747545) )

&nbsp;
## Microsoft SSRS: Report Builder
Microsoft Report builder , is a end user tool for create your personal Reports (from Web UI) on SSRS server or SharePoint

Its free with Microsoft SQL Server license

You can define Kylin as DataSource, but when use it to create DataSet fail: “Data Source name not found and no default driver speficied”

&nbsp;
## Microsoft SSRS: Visual Studio Data Tools (SSDT)
Is an extension to generate professional reports of SSRS using Visual Studio 

Its free with Microsoft SQL Server license

The error is similar to that Report Builder “Data Source name not found and no default driver speficied”

It seems that only work with certains providers proposed by default by Microsoft


&nbsp;
&nbsp;
## Others
Other tools that nowadays, can’t work with Apache Kylin (need changes in code, doesn’t support SQL, doesn’t support ODBC sources, .... )

&nbsp;
### [Kibi](https://siren.solutions/kibi/) / [Kibana](https://www.elastic.co/products/kibana)
From: *Giovanni Tummarello* (thanks, for the info)

*“Kibi dashboard **DO NOT support SQL or JDBC** a Kibi datasource is only used for special filters or certain other operations, check the documentation. We will likely support it in the future though.
saying this so that you dont waste your time.. you will not be able to see anything now with Kibi if you dont load things in ES also”*

&nbsp;
### [Ploty](https://plot.ly/)
From: *Chris Parmer* (thanks, for the info)

*“Thanks for reaching out! **We haven't added this yet**. Do you use Apache Kylin at your work? We are going to be adding spark and redshift next before we get to something like Kylin.”*

&nbsp;
### [DataIku](http://www.dataiku.com/)
(Thanks to [Hugo Schmitt](https://www.linkedin.com/in/hugoschmitt/en) )
It’s a Visualization and Machine Learning tool. Imagine, if you have sales cube by dates, predict the sales using data of previous years  ;)

Extensible using [Plugins](http://www.dataiku.com/dss/plugins/)

DataIku, don’t support standard ODBC connector, the workaround is test with unofifcial JDBC sopport


&nbsp;
## ToDo:
Test and doc the integration of Kylin with [Saiku](http://www.meteorite.bi/products/saiku)

&nbsp;
&nbsp;

**For any suggestions, feel free to contact me**

**Thanks, Alberto**
