# mssql-windows
This is the Dockerfile for an extension on microsoft/mssql-server-windows-developer image.


## About this sample

1. **Applies to:** SQL Server Developer Edition, Windows Server 2016, Windows 10
5. **Authors:** Gunkut Zeybek

<a name=run-this-sample></a>

## Run this sample

The image is bsaed on [microsoft/mssql-server-windows-developer] (https://hub.docker.com/r/microsoft/mssql-server-windows-developer/). You can check the environment variables that can be set there. </br>

The only difference is the additional properties at **attach_dbs** parameter.
So the JSON format becomes:

  ```
  [
	{
		'dbName': 'FirstSampleDB',
        'dbUser': 'userForDB1',
        'dbUserPass': 'passwordForUser',
		'dbFiles': ['C:\\temp\\FirstSampleDB.mdf', 'c:\\temp\\FirstSampleDB_1.ldf']
	},
	{
		'dbName': 'SecondSampleDB',
        'dbUser': 'userForDB2',
        'dbUserPass': 'passwordForUser',
		'dbFiles': ['C:\\temp\\SecondSampleDB.mdf', 'C:\\temp\\SecondSampleDB_log.ldf']
	}
  ]
  ```

  This is an array of databases, which can have zero to N databases.

  Each consisting of:
  - **dbName**: The name of the database
  - **dbFiles**: An array of one or many absolute paths to the .MDF and .LDF files.
  - **dbUser**: The username that will be created as a login in the server and also will have the mappings for the database wih db_admin role assigned. 
  - **dbUserPass**: Password for the user that will be created according to the dbUser parameter.

This example shows all parameters in action:
```
docker container run -p 1433:1433 -e sa_password=P@ssw0rd -e ACCEPT_EULA=Y -e attach_dbs="[{'dbName':'SomeDBName','dbUser':'AUser','dbUserPass':'APassword','dbFiles':['.mdf','c:\\temp\\AshopCommerce_1.ndf','c:\\temp\\AshopCommerce_2.ld
f']}]" --network dockercompose_mssql_net --ip 172.16.238.10 -v C:/Program` Files/Microsoft` SQL` Server/MSSQL14.MSSQLSERVER/MSSQL/DATA:c:/temp/ -v C:/Personal/DockerCompose/MssqlDockerScript:C:/startupscript gunkut/mssql-windows:latest
```