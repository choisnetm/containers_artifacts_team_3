kubectl create secret `
    generic sql-secrets `
    --namespace=api `
    --from-literal ASPNETCORE_ENVIRONMENT=Development `
    --from-literal SQL_SERVER=sqlservernom9737.database.windows.net `
    --from-literal SQL_DBNAME=mydrivingDB `
    --from-literal SQL_USER=sqladminnOm9737 `
    --from-literal SQL_PASSWORD=Password123!