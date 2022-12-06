# create sql server container
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Password123!" `
   -p 1433:1433 --name oh_sqlserver --hostname changeme.database.windows.net `
   -d mcr.microsoft.com/mssql/server:2017-latest

# create docker network 
docker network create -d bridge oh_network --attachable 

# connect sql server to the network
docker network connect oh_network oh_sqlserver

# connect to sql server and create mydrivingDB
# create a login sqladmin as db_owner of mydrivingDB

# login to private registry
docker login registrynom9737.azurecr.io
# use login/password from Azure Resource

# pull database image and push it to the local sql server database
docker run --network oh_network -e SQLFQDN=changeme.database.windows.net -e SQLUSER=sqladmin -e SQLPASS=changeme -e SQLDB=mydrivingDB registrynom9737.azurecr.io/dataload:1.0

# go to the webapp source directory
Set-Location C:\git\Microsoft\containers_artifacts_team_3\src\poi
# build image
docker build --no-cache --build-arg IMAGE_VERSION="1.0" -f ..\..\dockerfiles\Dockerfile_3 -t "tripinsights/poi:1.0" .

# run web app image
docker run -d -p 8080:80 --name poi -e "SQL_PASSWORD=changeme" -e "SQL_SERVER=changeme.database.windows.net" -e "ASPNETCORE_ENVIRONMENT=Local" tripinsights/poi:1.0

# add to the network
docker network connect oh_network poi

Set-Location C:\git\Microsoft\containers_artifacts_team_3\src\user-java
# build for registry
docker build --no-cache --build-arg IMAGE_VERSION="1.0" -f ..\..\dockerfiles\Dockerfile_0 -t registrynom9737.azurecr.io/openhack/user-java:1.0 .
# push image to registry
docker image push registrynom9737.azurecr.io/openhack/user-java:1.0

Set-Location C:\git\Microsoft\containers_artifacts_team_3\src\tripviewer
# build for registry
docker build --no-cache --build-arg IMAGE_VERSION="1.0" -f ..\..\dockerfiles\Dockerfile_1 -t registrynom9737.azurecr.io/openhack/tripviewer:1.0 .
# push image to registry
docker image push registrynom9737.azurecr.io/openhack/tripviewer:1.0

Set-Location C:\git\Microsoft\containers_artifacts_team_3\src\userprofile
# build for registry
docker build --no-cache --build-arg IMAGE_VERSION="1.0" -f ..\..\dockerfiles\Dockerfile_2 -t registrynom9737.azurecr.io/openhack/userprofile:1.0 .
# push image to registry
docker image push registrynom9737.azurecr.io/openhack/userprofile:1.0

Set-Location C:\git\Microsoft\containers_artifacts_team_3\src\poi
# build for registry
docker build --no-cache --build-arg IMAGE_VERSION="1.0" -f ..\..\dockerfiles\Dockerfile_3 -t registrynom9737.azurecr.io/openhack/poi:1.0 .
# push image to registry
docker image push registrynom9737.azurecr.io/openhack/poi:1.0

Set-Location C:\git\Microsoft\containers_artifacts_team_3\src\trips
# build for registry
docker build --no-cache --build-arg IMAGE_VERSION="1.0" -f ..\..\dockerfiles\Dockerfile_4 -t registrynom9737.azurecr.io/openhack/trips:1.0 .
# push image to registry
docker image push registrynom9737.azurecr.io/openhack/trips:1.0

# Az cli can build and push
az acr build