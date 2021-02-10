# PostgreSQL
refer to onenote 银行金融 - 管理 - PostgreSQL and https://blog.logrocket.com/setting-up-a-remote-postgres-database-server-on-ubuntu-18-04/

1. [Configuration](#Configuration)
2. [Backup](#Backup)

steps | note
------- | --------------
install | find tutorial in network
free fire wall | sudo ufw allow 5432/tcp
restart service | sudo systemctl restart postgresql

## Configuration

![diagram](postgresql_conf.png)

![diagram](pg_hba_conf.png)

## Backup

backup management | - 
-----------|------------
backup folder | media/lnmycloud/backups
command | sudo pg_dump -U USERNAME -h REMOTE_HOST -p REMOTE_PORT NAME_OF_DB > LOCATION_AND_NAME_OF_BACKUP_FILE
or | pg_dump/pg_restore

  pg_dump -U username -f backup.dump database_name -Fc 
switch -F specify format of backup file:

c will use custom PostgreSQL format which is compressed and results in smallest backup file size
d for directory where each file is one table
t for TAR archive (bigger than custom format)
-h/--host Specifies the host name of the machine on which the server is running
-W/--password Force pg_dump to prompt for a password before connecting to a database
restore backup:

   pg_restore -d database_name -U username -C backup.dump
Parameter -C should create database before importing data. If it doesn't work you can always create database eg. with command (as user postgres or other account that has rights to create databases) createdb db_name -O owner
