wget https://raw.githubusercontent.com/sequenceiq/docker-kylin/master/ambari-functions
source ambari-functions/


Start Docker
   docker ps -a
   docker start 14
   docker exec -it 14 bash

Start Kylin
  check kylin, si no responde 
    /usr/local/apache-kylin-1.5.2.1-bin/bin/kylin.sh start
    /usr/local/apache-kylin-1.6.0-SNAPSHOT-bin/bin/kylin.sh start
	/usr/local/apache-kylin-1.6.0-bin/bin/kylin.sh start

  Los errores de arranque de Kylin estan en: /usr/local/kylin/logs/kylin.log

Webs:
  http://172.17.0.2:8080	Ambari 	admin / admin
  http://172.17.0.2:7070/kylin	ADMIN / KYLIN
  Si ambari no responde: ambari-agent stop
	

Versiones
  HBase 0.98.4
  HDFS 2.6.0
  Zookeeper 3.4.6
  CentOS release 6.6
  Kylin 1.5.2



INSTALL:
Creamos la imagen Docker
  cd ~/GitHub/Kylin_ARP/KylinWithDocker/
  sudo docker build -t albertozgz/kylin151:01 -f Dockerfile .

Deployamos los containers
  (Remove previous containers if there is)
  source ambari-functions
  kylin-deploy-cluster 1  #and wait (see rigth upper corn the % )
  check ambari, en especial HBase
Hay que construir el cubo, seguir las instrucciones de la Web
    no hace falta importar datos si se usa esta docker imagen
    tarda en arrancar, se queda como trabajo en pendiente como 30 secs


Check deploy problems in:  /var/log/kylin-deploy.log

ToDo:  Use root for deploy Kylin --> Need be root to execute --> Root isn't super-user of HDFS
	ERROR: AccessControlException: Permission denied: user=root, access=WRITE, inode="/kylin":hdfs:hdfs:drwxr-xr-x
	temporal solution: runuser -l hdfs -c "hadoop fs -chmod -R 777 /kylin"
	
UPGRADE KILYN (runing container)
  Download correct version for HBase
  tar -xvzf 
  docker cp apache-kylin-1.6.0-SNAPSHOT-bin 14:/usr/local/
  docker cp apache-kylin-1.6.0-bin 14:/usr/local/
  
  Acordarse de actualizar KYLIN_HOME, una solucion es que KYLIN_HOME sea un soft link y redireccionarlo
  	cd /usr/local
  	ln -sfn /usr/local/apache-kylin-1.6.0-bin kylin
	
UPGRADE KYLIN (wich deploy with container)
	Update DockerFile (x 2Lines)

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

