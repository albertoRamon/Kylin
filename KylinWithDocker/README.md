# Docker Image for Kylin using AWS

<p align="center">
  <img src=./Images/00.png />
</p>

_This is a modification of sequenceiq/kylin:0.7.2_

### Abstract
Mount quickly an Apache Kylin on AWS thanks to Docker, Without having to access a Hadoop cluster.

### Requirements
Amazon instance with:
* 4 Cores
* 8 GB RAM
* 16 GB HD

We can use _c4.xlarge_ or superior:
<p align="center">
  <img src=./Images/08.png />
</p>

Add Disk space, by default has only 8 and it is not enough:
<p align="center">
  <img src=./Images/09.png />
</p>

Create _Security Group_, we will need change ports more late:
<p align="center">
  <img src=./Images/10.png />
</p>

### Connect to Amazon IAM
Connect to your AIM, in my case:
```bash
ssh -i "/home/arp/.ssh/id_rsa.pem" ec2-user@ec2-54-219-131-131.us-west-1.compute.amazonaws.com
```

### Install Docker & GIT

Install  docker & git: [Detailed Manual](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html#install_docker)
```bash
sudo yum update -y &&
sudo yum install -y docker git &&
sudo service docker start &&
sudo usermod -a -G docker ec2-user 
```

**Log out** and reconnect (if not docker doesn't run OK)
```bash
docker -info &&
git --version 
```

### Clone GitHub to get docker file
```bash
cd ~ &&
mkdir kylin &&
cd kylin  &&
git init &&
git remote add -f origin https://github.com/albertoRamon/Kylin &&
git config core.sparseCheckout true &&
echo "KylinWithDocker/" >> .git/info/sparse-checkout &&
git pull origin master 
```

### Pull Docker image and run
```bash
cd KylinWithDocker &&
sudo docker build -t albertozgz/kylin160:01 -f Dockerfile . &&
source ambari-functions &&
kylin-deploy-cluster 1
```
The standard output will be similar to this:

Pull required layers:
<p align="center">
  <img src=./Images/01.png />
</p>

Start to execute dockerfile, command to install software:
<p align="center">
  <img src=./Images/02.png />
</p>
Packages dependencies:
<p align="center">
  <img src=./Images/03.png />
</p>
Downloading & Installing software:
<p align="center">
  <img src=./Images/04.png />
</p>
Open ports of Docker image:
<p align="center">
  <img src=./Images/05.png />
</p>
Configure Hadoop install:
<p align="center">
  <img src=./Images/06.png />
</p>
Installing Hadoop components:
<p align="center">
  <img src=./Images/11.png />
</p>
Starting Hadoop Components:
<p align="center">
  <img src=./Images/12.png />
</p>
Finished:
<p align="center">
  <img src=./Images/13.png />
</p>

The install by default started Hadoop Cluster and Kylin service, thus you only need connect to the web pages of them to check it.

### Open ports:
Show map of ports of containers:
```bash
docker ps 
```
<p align="center">
  <img src=./Images/07.png />
</p>

In my case the map is like this, the left columns will be different:
<p align="center">
  <img src=./Images/15.png />
</p>

Then we need open Local ports on Amazon Instance to access from outside, in _Security Group_ find _Docker01_ and configure as picture:
<p align="center">
  <img src=./Images/16.png />
</p>

### How to turn-on
**Turn-on Docker container**
```bash
docker start <containerID>  
```
**Turn-on Hadoop cluster**

We need know own Public DNS (It can be changed if we restarted the instance):
<p align="center">
  <img src=./Images/20.png />
</p>

Compose the URL of Ambary, _http://hostname:8080_
In my case:
* Host name: http://ec2-54-219-131-131.us-west-1.compute.amazonaws.com
* The port 8080 of container is mapped to 32772 (check your own case)
```
http://ec2-54-219-131-131.us-west-1.compute.amazonaws.com:32772
```
Enter with default login/password: _admin/admin_
<p align="center">
  <img src=./Images/17.png />
</p>

See the main dashboard of Ambari:
<p align="center">
  <img src=./Images/18.png />
</p>

Check status of services, must be _started_ like this:
<p align="center">
  <img src=./Images/19.png />
</p>

**Turn-on Apache Kylin**

Open a bash console with container
```bash
docker exec -it <containerID> bash 
```
Check your propt has been changed:
<p align="center">
  <img src=./Images/21.png />
</p>
In the container execute:

```bash
/usr/local/apache-kylin-1.6.0-bin/bin/kylin.sh start
```
You must see a message similar to this:
<p align="center">
  <img src=./Images/25.png />
</p>


Connect to Apache Kylin UI, with this format _http://hostname:7070/kylin_
In my case:
* Host name: http://ec2-54-219-131-131.us-west-1.compute.amazonaws.com
* The port 7070 of container is mapped to 32775 (check your own case)
**Don't forget** /kylin sufix, if not dont work
```
http://ec2-54-219-131-131.us-west-1.compute.amazonaws.com:32775/kylin
```
Enter with default login/password: _ADMIN/KYLIN_

<p align="center">
  <img src=./Images/22.png />
</p>

You can see the main dashboard of Apache Kylin:
<p align="center">
  <img src=./Images/24.png />
</p>

### How to turn-off 
**Turn-off Apache Kylin**

Open a bash console with container
```bash
docker exec -it de396dd7665e bash 
```
Check your propt has been changed:
<p align="center">
  <img src=./Images/21.png />
</p>
In the container execute:

```bash
/usr/local/apache-kylin-1.6.0-bin/bin/kylin.sh stop
```
You must see a message similar to this:
<p align="center">
  <img src=./Images/25.png />
</p>

**Turn-off Hadoop cluster**

Acceess to Ambari web console, and click: 
![alt text](./Images/27.png) > ![alt text](./Images/28.png)

All services will be stoped:
<p align="center">
  <img src=./Images/26.png />
</p>

**Turn-off Container**
```bash
docker stop <containerID>  
```

### Next Steps

**Build Example Cube**

This is the most simple cube ready to build after installation, with out configuration
[How to build the cube](http://kylin.apache.org/docs15/tutorial/kylin_sample.html)

In this AWS machine with default config only take 6.15 min
<p align="center">
  <img src=./Images/29.png />
</p>

To build a dashboard whit this cube see: [Connect from Tableau step by step](https://github.com/albertoRamon/Kylin/tree/master/KylinWithTableau)

**Check Apache Kylin Documentation**

[Kylin Docks:](http://kylin.apache.org/docs20/) You will find a Getting Started and Tutorial very useful

**Build a cube step by step**

[Analyze Amazon Reviews with Apache Kylin](https://github.com/albertoRamon/Kylin/tree/master/KylinAmazon): Practical example about how to create a cube from data provided of an external data source 

**How to upgrade/change Kylin version**

Some tips about how-to it this, If you are interested to practice with new versions of Kylin 2.0 and new features

Change in docker file:
```
RUN curl -sL http://apache.rediris.es/kylin/apache-kylin-1.6.0/apache-kylin-1.6.0-bin.tar.gz | tar -xz -C /usr/local
RUN cd /usr/local && ln -s ./apache-kylin-1.6.0-bin kylin
```

Change with build cointainer command:
```
sudo docker build -t albertozgz/kylin160:01 -f Dockerfile . &&
```

Change the start command:
```
/usr/local/apache-kylin-1.6.0-bin/bin/kylin.sh start
```

**Improve this Apache kylin on Docker**

If you will want reuse this docker for bigger projects, the first step is configure the YARN resources (cores and RAM used to build the cube)
<p align="center">
  <img src=./Images/30.png />
</p>
<p align="center">
  <img src=./Images/31.png />
</p>

**Issues**

* The 90% of problems is because HBase is shutdown. Check its status from Ambari

* If Ambari don't start: restart Ambari Agent
```
ambari-agent stop  & ambari-agent start
```
* Adapt your YARN configuration to the size of your Amazon instance

