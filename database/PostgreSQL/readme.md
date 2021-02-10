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
backup folder | media/backup
command | sudo pg_dump -U USERNAME -h REMOTE_HOST -p REMOTE_PORT NAME_OF_DB > LOCATION_AND_NAME_OF_BACKUP_FILE
