# How to use Hue with Kylin

**Date:** August 2016

**Author:** Ramón Portolés, Alberto  ![alt text](./Images/00.png)  [Linkedin](https://www.linkedin.com/in/alberto-ramon-portoles-a02b523b "My Linkedin") 

&nbsp;

### Intro
 In [Hue-2745](https://issues.cloudera.org/browse/HUE-2745) v3.10, add jdbc support like Phoenix, Kylin, Redshift, Solr Parallel SQL, …

But … there isn’t any manual to use it  with Kylin 	:(
### Pre-requisites
We need an instance of Kylin, with a cube: [Quick Start with Sample Cube](http://kylin.apache.org/docs15/tutorial/kylin_sample.html), will be enough

You can check: 
<p align="center">
  <img src=./Images/01.png />
</p>

### Used Software:
* [Apache Hue](http://gethue.com/) v3.10.0
* [Apache Kylin](http://kylin.apache.org/) v1.5.2

&nbsp;
## 1  Install Apache Hue
If you have Hue installed, you can skip this step

I installed Hue on my Ubutu 16.04 LTS. The [official Instructions](http://gethue.com/how-to-build-hue-on-ubuntu-14-04-trusty/) didn’t work but [this](https://github.com/cloudera/hue/blob/master/tools/docker/hue-base/Dockerfile) works fine:

### 1.A Install & compile Hue:
There isn’t any binary package thus we need install all [pre-requisites](https://github.com/cloudera/hue#development-prerequisites) to compile with make

    Sudo apt-get install --fix-missing -q -y \
    git \
    ant \
    gcc \
    g++ \
    libkrb5-dev \
    libmysqlclient-dev \
    libssl-dev \
    libsasl2-dev \
    libsasl2-modules-gssapi-mit \
    libsqlite3-dev \
    libtidy-0.99-0 \
    libxml2-dev \
    libxslt-dev \
    libffi-dev \
    make \
    maven \
    libldap2-dev \
    python-dev \
    python-setuptools \
    libgmp3-dev \
    libz-dev

### Download and Compile:
    git clone https://github.com/cloudera/hue.git
    cd hue
    make apps

&nbsp;
## 1.B Start and connect
To start Hue:

    build/env/bin/hue runserver_plus localhost:8888
* runserver_plus: is like runserver with debugger
* localIP: Port, usually Hue uses 8888

The output must be similar to:
<p align="center">
  <img src=./Images/02.png />
</p>

Connect using your browser: http://localhost:8888
<p align="center">
  <img src=./Images/03.png />
</p>

**Important:** The first time that you connect to hue, are you setting Login / Pass  for admin

We will use Hue / Hue, as login / pass

&nbsp;
### Issue 1: Could not create home directory
<p align="center">
  <img src=./Images/04.png />
</p>
Its a permission problem of your current user, you can use: sudo to start Hue 

### Issue 2: Could not connect to … 
<p align="center">
  <img src=./Images/05.png />
</p>
If you downloaded Hue’s code from Git, Hive connection is active but not configured → you can skip this message

### Issue 3: Address already in use
<p align="center">
  <img src=./Images/06.png />
</p>
The port is in use or you have other instance of Hue running

You can use *ps -ef | grep hue*, to find the pid and kill

&nbsp;
## 2  Configure Apache Hue for Kylin
Our purpose is add a snipped in one notebook with Kylin queries

### References:
* [Custom SQL Databases](http://gethue.com/custom-sql-query-editors/)	
* [Manual: Kylin JDBC Driver](http://kylin.apache.org/docs/howto/howto_jdbc.html)
* [GitHub: Kylin JDBC Driver](https://github.com/apache/kylin/tree/3b2ebd243cfe233ea7b1a80285f4c2110500bbe5/jdbc)

### Register JDBC Driver

1. We need find tha JAR Class for JDBC Connector

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; From Kylin [Download](http://kylin.apache.org/download/)
Choose **Binary** and the **correct version of Kylin and HBase**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Download & Unpack:  in ./lib: 
<p align="center">
  <img src=./Images/07.png />
</p>

2. Put this JAR in you Java ClassPATH in your .bashrc
<p align="center">
  <img src=./Images/08.png />
</p>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  check the actual value: ![alt text](./Images/09.png)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  check permission for this file (Must be accessible for you):
<p align="center">
  <img src=./Images/10.png />
</p>

3. Add this new interface into your Hue.ini

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Where is my hue.ini ? 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If you install from Git you are using:  *UnzipPath/desktop/conf/pseudo-distributed.ini*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  (I shared my *INI* file in GitHub)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If you are using Cloudera: you must use Advanced Configuration Snippet

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Other: find you actual *hue.ini*

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Add this lines inside *[[interpreters]]*

    [[[kylin]]]
    name=kylin JDBC
    interface=jdbc
    options='{"url": "jdbc:kylin://172.17.0.2:7070/learn_kylin","driver": "org.apache.kylin.jdbc.Driver", "user": "ADMIN", "password": "KYLIN"}'

4. Try to Start Hue and connect Like ‘Start and connect’

TIP: you will need one JDBC Source for each project

&nbsp;
### Register without password:
We can use this other format:

    options='{"url": "jdbc:kylin://172.17.0.2:7070/learn_kylin","driver": "org.apache.kylin.jdbc.Driver"}'

And when you connect to Notebook, Hue prompts this:
<p align="center">
  <img src=./Images/11.png />
</p>

&nbsp;
### Issue 1: Hue can’t Start
If when connect to Hue ( http://localhost:8888 ), you see this:
<p align="center">
  <img src=./Images/12.png />
</p>

You can go to last line ![alt text](./Images/13.png) 

And launch Python Interpreter (see console icon at right):
<p align="center">
  <img src=./Images/14.png />
</p>
In my case: I forgotten “ after learn_kylin

### Issue 2: Password Prompting
In Hue 3.11 there is a bug [Hue 4716](https://issues.cloudera.org/browse/HUE-4716)

In Hue 3.10 with Kylin, I don’t have any problem   :)

&nbsp;
## 3  Test querie Example
Add in yours Kylin’s notebook:

 ![alt text](./Images/15.png) > ![alt text](./Images/16.png)  > ![alt text](./Images/17.png)  > ![alt text](./Images/18.png) 


Write a querie, like this:

    select part_dt, sum(price) as total_selled, count(distinct seller_id) as sellers from kylin_sales group by part_dt order by part_dt

And Execute with: ![alt text](./Images/19.png) 
<p align="center">
  <img src=./Images/20.png />
</p>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **Congratulations ¡¡¡** &nbsp;&nbsp; you are connected Hue with Kylin

&nbsp;
### Issue 1:  No suitable driver found for jdbc:kylin
<p align="center">
  <img src=./Images/21.png />
</p>
There is a bug,not solved at 27 Ago 2016, nor in 3.10 and 3.11, 
but the solution is very easy (Thanks to Shahab Tajik)

[Link](https://github.com/cloudera/hue/pull/369): 
You only need change 3 lines in  *<HuePath>/desktop/libs/librdbms/src/librdbms/jdbc.py*

&nbsp;
## 4  Limits
Nowadays, in Hue 3.10 and 3.11
* Auto-complete isn’t support on JDBC interfaces
* Max 1.000 records. There is a limitation on JDBC interfaces, because Hue does not support pagination of results [Hue 3419](https://issues.cloudera.org/browse/HUE-3419)
* Obviously:  It’s only for read-only 

&nbsp;
## 5  Future Work

### Dashboards
There is an amazing feature of Hue: [Searh Dasboards](http://gethue.com/search-dashboards/) / [Dynamic Dashboards](http://gethue.com/hadoop-search-dynamic-search-dashboards-with-solr/). You can ‘play’ with this [Demo On-line](http://demo.gethue.com/search/admin/collections) … **But only works with SolR**

There is a Jira to solve this: [Hue 3228](https://issues.cloudera.org/browse/HUE-3228), RoadMap 4.1 Hue [MailList](https://groups.google.com/a/cloudera.org/forum/#!topic/hue-user/B6FWBeoqK7I) and add Dashboards to JDBC connections

### Chart & Dynamic Filter
Nowadays, Isn’t compatible, you only can work with Grid

I think the problem is , Hue don’t know how read Kylin Metadata  [Hue 4011](https://issues.cloudera.org/browse/HUE-4011)
<p align="center">
  <img src=./Images/22.png />
</p>

### DB Query
 ![alt text](./Images/23.png) > ![alt text](./Images/24.png) , Is not yet supported with JDBC 

Now only support [Django Databases](https://docs.djangoproject.com/en/1.9/topics/install/#database-installation)


&nbsp;
&nbsp;

**For any suggestions, feel free to contact me**

**Thanks, Alberto**

