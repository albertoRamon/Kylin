# MeetUp Madrid Kylin


El PPT se puede bajar de esta misma carpeta


### LAB 1
En las siguienes URL hay unos cubos demos: 
* [AirLines (batch)](http://kapdemo.chinaeast.cloudapp.chinacloudapi.cn:8080/)
* [Twitter (stream)](http://hub.kyligence.io/twitter-demo/twitter/) (en casa)

**Interfaz WEB Grafico:**

DataSet: 150 Millones de vuelos en los ultimos 30 years

Numero de vuelos por dia de la semana:
<p align="center">
  <img src=./Images/01.png />
</p>

Numero de vuelos por year & month:
<p align="center">
  <img src=./Images/02.png />
</p>


**Acceder al backend via WEB**

Acceder al puerto 7070 (Puerto por defecto Apache Kylin UI) con el mismo login y password

Query de ejemplo:
```sql
select part_dt, sum(price) as total_selled, count(distinct seller_id) as sellers from kylin_sales group by part_dt order by part_dt
```
   
<p align="center">
  <img src=./Images/03.png />
</p>
Ver que el tiempo de respuesta son 300ms !!

**Acceder al backend con Tableau Local**
[Manual](https://github.com/albertoRamon/Kylin/tree/master/KylinWithTableauFast)
Si tienes Tablau instalado, puedes montarlo rapidamente tu mismo

### LAB 2
Montar una maquina desde cero, usando Amazon Web Services y Docker
[Manual](https://github.com/albertoRamon/Kylin/tree/master/KylinWithDocker)


### LAB 3 (en casa)
[Manual](https://github.com/albertoRamon/Kylin/tree/master/KylinAmazon)

Una vez tengamos instalada una maquina con Apache Kylin, podemos crear nuestro propio cubo desde cero paso a paso

En este caso se trabaja con un dataset publico de Amazon de 80 Millones de Rows


### Cuidado con Windows y los conectores ODBC:

<p align="center">
  <img src=./Images/ODBCNota.png />
</p>
