# Docker Compose 

## Installation of docker compose on linux client 

```
779  sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  780  sudo chmod +x /usr/local/bin/docker-compose
  781  sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
  782  docker-compose  -v

```

## link for installation docker compose 

[link compose] ('https://docs.docker.com/compose/install/')

## COmpose file version 

[file version link] ('https://docs.docker.com/compose/compose-file/')

## Compose file overview 

<img src="compose.png">

## Docker compose file example 1 :

```
[centos@ip-172-31-71-212 myashuapp1]$ cat docker-compose.yml 
version: "3.8"  
services:
 appweb:
  image: nginx
  container_name: ashuc11
  restart: always
  ports:
   - "1122:80"

# docker run --name ashuc11 --restart always -p 1122:80 nginx

```
## Docker compose commands

```
798  docker-compose up -d
  799  docker-compose ps
  800  cat docker-compose.yml 
  801  history 
  802  docker-compose ps
  803  ls
  804  clear
  805  docker-compose ps
  806  docker-compose 
  807  history 
  808  docker-compose  ps
  809  docker-compose  stop 
  810  docker-compose  ps
  811  docker-compose  start
  812  docker-compose  ps
  813  docker-compose  kill
  814  docker-compose  ps
  815  docker-compose  start
  816  docker-compose  kill
  
  ```
  
## Most easier way 

```
[centos@ip-172-31-71-212 myashuapp1]$ docker-compose up -d
Creating network "myashuapp1_default" with the default driver
Creating ashuc11 ... done
[centos@ip-172-31-71-212 myashuapp1]$ docker-compose down
Stopping ashuc11 ... done
Removing ashuc11 ... done
Removing network myashuapp1_default

```

## Jenkins job for CI CD

<img src="jenkin.png">

## compose file example 2

```
[centos@ip-172-31-71-212 myashuapp1]$ cat docker-compose.yml 
version: "3.8"  
services:
 testapp:
  image: alpine
  container_name: ashuccx33
  command: ping fb.com
  restart: always 

 appweb:
  image: nginx
  container_name: ashuc11
  restart: always
  ports:
   - "1122:80"



```

## Docker compose more Examples 

[ashutoshh repo] ('https://github.com/redashu/docker-compose')


