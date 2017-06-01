# IDEAS
# Definir en un array nombres de TB o incluso detectar por el prefijo
# Sacar todos los paths a variables
# El nuemro de la imagen tiene que ser una variable
# Que arranque o check todos los serivicios
#

PathProject='~/GitHub/Kylin_ARP/KylinAmazon'
ContainerID='58b'


# Funtions

function check_Container_Runing {
	cmd=$( docker ps -f "id=${ContainerID}" -q )
	if [ ${#cmd} -ge ${#ContainerID} ]; then
		echo "Container is Runing"
	else 
		echo "Container is NOT Runing"
		check_Container_exist
	fi
}

function check_Container_exist {
	cmd=$( docker ps -f "id=${ContainerID}" -q -a)
	if [ ${#cmd} -ge ${#ContainerID} ]; then
		echo "Container is in STOP"
		start_Container
	else 
		echo "Container doesn't exist"
		exit 1
	fi
}

function start_Container {
   #docker exec -it 58 bash
	cmd=$( docker start ${ContainerID} )
	ret_code=$?
	if [ $ret_code != 0 ]; then
		echo "Error when executing command: "
	fi
	if [ "${cmd}" == "${ContainerID}" ]; then
		echo "Container started"
	else 
		echo "Uncontroled Error"
		exit 1
	fi
}

function find_webrowser {
	cmd=$( type firefox 2>/dev/null )
	ret_code=$?
	if [ $ret_code != 0 ]; then
		echo "Error Browser didnt find: "
	fi
	
	# ToDo
	# open 2 link (ambary an Kylin UI)
	#Check if Hive, HBase and Kylin is runing, if not wait and start
	# https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=41812517
	
}

check_Container_Runing

cd ${PathProject}
#Execute from HOST  
	echo "Copying data"
	docker exec ${ContainerID} mkdir -p /Amazon_Review/
	docker cp ./DataProcesed/item_dedup.csv.bz2 ${ContainerID}:/Amazon_Review/
	docker cp ./DataProcesed/metadata.csv.bz2 ${ContainerID}:/Amazon_Review/
	echo "Copying data: OK"

	echo "Create Tables & ingest data"
	docker cp ./Scripts/02-CreateTB.sql ${ContainerID}:/Amazon_Review/	
	docker exec ${ContainerID} hive -f /Amazon_Review/02-CreateTB.sql
	echo "Create Tables & ingest data:OK"


