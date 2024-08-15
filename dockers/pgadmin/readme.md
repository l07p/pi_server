# Docker image pgadmin with yml file
## volume on ubuntu somewhere
/home/ubuntu/dockers/pgadmin/data:/var/lib/pgadmin
## Access the Running pgAdmin Container with 'sh':
$ docker exec -it <pgadmin_container_name> sh
## Reset password of postgres
ALTER USER postgres PASSWORD 'root';

