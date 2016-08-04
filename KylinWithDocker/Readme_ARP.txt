wget https://raw.githubusercontent.com/sequenceiq/docker-kylin/master/ambari-functions
source ambari-functions/

Webs:
  http://172.17.0.2:8080	Ambari 	admin / admin
  http://172.17.0.2:7070/kylin	ADMIN / KYLIN

   docker exec 89 bash
	

Versiones
  HBase 0.98.4
  HDFS 2.6.0
  Zookeeper 3.4.6
  CentOS release 6.6

Creamos la imagen Docker
  sudo docker build -t albertozgz/kylin151:01 -f Dockerfile .

Deployamos los containers
  source ambari-functions
  kylin-deploy-cluster 1
  check ambari, en especial HBase
  check kylin, si no responde /usr/local/apache-kylin-1.5.2.1-bin/bin/kylin.sh start
  Los errores de arranque de Kylin estan en: /usr/local/apache-kylin-1.5.2.1-bin/logs/kylin.log


Check deploy problems in:  /var/log/kylin-deploy.log

ToDo:  Use root for deploy Kylin --> Need be root to execute --> Root isn't super-user of HDFS
	ERROR: AccessControlException: Permission denied: user=root, access=WRITE, inode="/kylin":hdfs:hdfs:drwxr-xr-x
	temporal solution: runuser -l hdfs -c "hadoop fs -chmod -R 777 /kylin"
	
Si ambari no responde: ambari-agent stop

PORTs:
 Desconocidos
  7373
  7946

 Maestros  
  16010	Master HBase 		http://172.17.0.2:60010/
  50070	NameNode		http://172.17.0.2:50070/
  19888 MapReduce2		http://172.17.0.2:19888/
  8088	MR historical  


 Slaves
 
 BUG
 KYLIN-1838 Fix sample cube definition 
	 https://github.com/apache/kylin/commit/90a234e3d893edd1993aeb2ff89c346a41fd41e7
	 https://issues.apache.org/jira/browse/KYLIN-1838

