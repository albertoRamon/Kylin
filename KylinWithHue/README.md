# Connect from Apache Hue

**Date:** August 2016

**Author:** Ramón Portolés, Alberto  ![alt text](./Images/00.png)  [Linkedin](https://www.linkedin.com/in/alberto-ramon-portoles-a02b523b "My Linkedin") 

### Introduction
 In [Hue-2745](https://issues.cloudera.org/browse/HUE-2745) v3.10, add jdbc support like Phoenix, Kylin, Redshift, Solr Parallel SQL, …

However, there isn’t any manual to use with Kylin 	:(

### Pre-requisites
Build a cube sample of Kylin with: [Quick Start with Sample Cube](http://kylin.apache.org/docs15/tutorial/kylin_sample.html), will be enough

You can check: 
<p align="center">
  <img src=./Images/01.png />
</p>

### Used Software:
* [Apache Hue](http://gethue.com/) v3.10.0
* [Apache Kylin](http://kylin.apache.org/) v1.5.2


### Install Apache Hue
If you have Hue installed, you can skip this step

To install Hue on Ubuntu 16.04 LTS. The [official Instructions](http://gethue.com/how-to-build-hue-on-ubuntu-14-04-trusty/) didn’t work but [this](https://github.com/cloudera/hue/blob/master/tools/docker/hue-base/Dockerfile) works fine:

There isn’t any binary package thus  [pre-requisites](https://github.com/cloudera/hue#development-prerequisites) must be installed and compile with the command *make*

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

Download and Compile:

    git clone https://github.com/cloudera/hue.git
    cd hue
    make apps


Start and connect to Hue:

    build/env/bin/hue runserver_plus localhost:8888
* runserver_plus: is like runserver with [debugger](http://django-extensions.readthedocs.io/en/latest/runserver_plus.html#usage)
* localIP: Port, usually Hue uses 8888

The output must be similar to:
<p align="center">
  <img src=./Images/02.png />
</p>

Connect using your browser: http://localhost:8888
<p align="center">
  <img src=./Images/03.png />
</p>

Important: The first time that you connect to hue, you set Login / Pass  for admin

We will use Hue / Hue as login / pass


**Issue 1:** Could not create home directory
<p align="center">
  <img src=./Images/04.png />
</p>

   It is a permission problem of your current user, you can use: sudo to start Hue

**Issue 2:** Could not connect to … 
<p align="center">
  <img src=./Images/05.png />
</p>
   If Hue’s code  had been downloaded from Git, Hive connection is active but not configured → skip this message  

**Issue 3:** Address already in use
<p align="center">
  <img src=./Images/06.png />
</p>
   The port is in use or you have a Hive process running already

  You can use *ps -ef | grep hue*, to find the PID and kill


### Configure Apache Hue for Kylin
The purpose is to add a snipped in a notebook with Kylin queries

References:
* [Custom SQL Databases](http://gethue.com/custom-sql-query-editors/)	
* [Manual: Kylin JDBC Driver](http://kylin.apache.org/docs/howto/howto_jdbc.html)
* [GitHub: Kylin JDBC Driver](https://github.com/apache/kylin/tree/3b2ebd243cfe233ea7b1a80285f4c2110500bbe5/jdbc)

Register JDBC Driver

1. To find the JAR Class for the JDBC Connector

 From Kylin [Download](http://kylin.apache.org/download/)
Choose **Binary** and the **correct version of Kylin and HBase**

 Download & Unpack:  in ./lib: 
<p align="center">
  <img src=./Images/07.png />
</p>

2. Place this JAR in Java ClassPATH using .bashrc
<p align="center">
  <img src=./Images/08.png />
</p>

  check the actual value: ![alt text](./Images/09.png)

  check the permission for this file (must be accessible to you):
<p align="center">
  <img src=./Images/10.png />
</p>

3. Add this new interface to Hue.ini

  Where is the hue.ini ? 

 * If the code is downloaded from Git:  *UnzipPath/desktop/conf/pseudo-distributed.ini*

   (I shared my *INI* file in GitHub).

 * If you are using Cloudera: you must use Advanced Configuration Snippet

 * Other: find your actual *hue.ini*

 Add these lines in *[[interpreters]]*

    [[[kylin]]]
    name=kylin JDBC
    interface=jdbc
    options='{"url": "jdbc:kylin://172.17.0.2:7070/learn_kylin","driver": "org.apache.kylin.jdbc.Driver", "user": "ADMIN", "password": "KYLIN"}'

4. Try to Start Hue and connect just like in ‘Start and connect’

TIP: One JDBC Source for each project is need


Register without a password, it can do use this other format:

    options='{"url": "jdbc:kylin://172.17.0.2:7070/learn_kylin","driver": "org.apache.kylin.jdbc.Driver"}'

And when you open the Notebook, Hue prompts this:
<p align="center">
  <img src=./Images/11.png />
</p>


**Issue 1:** Hue can’t Start

If you see this when you connect to Hue  ( http://localhost:8888 ):
<p align="center">
  <img src=./Images/12.png />
</p>

Go to the last line ![alt text](./Images/13.png) 

And launch Python Interpreter (see console icon on the right):
<p align="center">
  <img src=./Images/14.png />
</p>
In this case: I've forgotten to close “ after learn_kylin

**Issue 2:** Password Prompting

In Hue 3.11 there is a bug [Hue 4716](https://issues.cloudera.org/browse/HUE-4716)

In Hue 3.10 with Kylin, I don’t have any problem   :)


## Test query Example
Add Kylin JDBC as source in the Kylin’s notebook:

 ![alt text](./Images/15.png) > ![alt text](./Images/16.png)  > ![alt text](./Images/17.png)  > ![alt text](./Images/18.png) 


Write a query, like this:

    select part_dt, sum(price) as total_selled, count(distinct seller_id) as sellers from kylin_sales group by part_dt order by part_dt

And Execute with: ![alt text](./Images/19.png) 
<p align="center">
  <img src=./Images/20.png />
</p>

 **Congratulations !!!**  you are connected to Hue with Kylin


**Issue 1:**  No suitable driver found for jdbc:kylin
<p align="center">
  <img src=./Images/21.png />
</p>
There is a bug,not solved since 27 Aug 2016, nor in 3.10 and 3.11, 
but the solution is very easy (Thanks to Shahab Tajik)

[Link](https://github.com/cloudera/hue/pull/369): 
You only need to change 3 lines in  *<HuePath>/desktop/libs/librdbms/src/librdbms/jdbc.py*


## Limits
In Hue 3.10 and 3.11
* Auto-complete doesn’t work on JDBC interfaces
* Max 1.000 records. There is a limitation on JDBC interfaces, because Hue does not support result pagination [Hue 3419](https://issues.cloudera.org/browse/HUE-3419)
* Obviously:  It’s read-only 


### Future Work

**Dashboards**
There is an amazing feature of Hue: [Searh Dasboards](http://gethue.com/search-dashboards/) / [Dynamic Dashboards](http://gethue.com/hadoop-search-dynamic-search-dashboards-with-solr/). You can ‘play’ with this [Demo On-line](http://demo.gethue.com/search/admin/collections) … **But this only works with SolR**

There is a Jira to solve this: [Hue 3228](https://issues.cloudera.org/browse/HUE-3228), is in RoadMap for 4.1. Check Hue MailList[MailList](https://groups.google.com/a/cloudera.org/forum/#!topic/hue-user/B6FWBeoqK7I)  and add Dashboards to JDBC connections

**Chart & Dynamic Filter**
Nowadays, It isn’t compatible, you only can work with Grid

I think the problem is that Hue doesn’t know how to read Kylin Metadata  [Hue 4011](https://issues.cloudera.org/browse/HUE-4011)
<p align="center">
  <img src=./Images/22.png />
</p>

**DB Query**
 ![alt text](./Images/23.png) > ![alt text](./Images/24.png) , is not yet supported with JDBC 

Now it only supports [Django Databases](https://docs.djangoproject.com/en/1.9/topics/install/#database-installation)





**For any suggestions, feel free to contact me**

**Thanks, Alberto**

