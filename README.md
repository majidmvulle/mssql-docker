
# MSSQL Server on Docker with custom a custom volume

We will be building containwea `db1` and `db2` that will use volumes `mssqlserver` and `mssqluser`.

## Create volumes
* Create the `mssqlserver` volume to hold database data by running the command:

```
docker volume create mssqlserver
```
* Create the `mssqluser` volume to hold user data by running the command:

```
docker volume create mssqluser
```

## Create & destroy db1 container
Run the command below to create the `db1` service. This service will utilize the SQL script [./scripts/create-db.sql](./scripts/create-db.sql) to create a database called `motfDb` and a table `Inventory` and insert some rows.

* Build the container with the command below:

```
docker-compose -f docker-compose-db1.yml build
```
* Run the container. Use `-d` to run in the background

```
docker-compose -f docker-compose-db1.yml run -d db1
```
* When the container is up and running 
	* You should connect to the container in CLI and run the command below to set up the database

	```
	/opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U sa -P 'Password1?' -i /scripts/create-db.sql
	```
	
	* You can connect to the container in CLI and use `sqlcmd` with the username `sa` and password `Password1?`. See the command below:

```
/opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U sa -P 'Password1?'
```

You can then use the database `motfDb` and select rows from the `Inventory` table. You should see 3 rows of _fruits_ with quantities.

| id | name   | quantity |
|----|--------|----------|
| 1  | banana | 150      |
| 2  | orange | 120      |
| 3  | apple  | 90       |

* Destroy the container `db1`


## Create db2 container

Run the command below to create the `db2` container. This will create a db2 service and use the same volume as `db1`. This service does not use the database creation and data insertion script as the `db1`, however, we expect to see the same data as seen in `db1` earlier even though that container was destroyed.

* Build the container with the command below:

```
docker-compose -f docker-compose-db2.yml build
```
* Run the container. Use `-d` to run in the background

```
docker-compose -f docker-compose-db2.yml run -d db2
```
* When the container is up and running you can connect to the container in CLI and use `sqlcmd` with the username `sa` and password `Password1?`. See the command below:

```
/opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U sa -P 'Password1?'
```

You can then use the database `motfDb` and select rows from the `Inventory` table. You should see 3 rows of fruits with quantities.

## Resources 
[https://dbafromthecold.com/2019/03/21/using-docker-named-volumes-to-persist-databases-in-sql-server/](https://dbafromthecold.com/2019/03/21/using-docker-named-volumes-to-persist-databases-in-sql-server/)

[https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-configure?view=sql-server-ver15&pivots=cs1-bash](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-configure?view=sql-server-ver15&pivots=cs1-bash)