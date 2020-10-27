# Docker & K8s 

## web server 

<img src="web.png">

## VM vs containers

<img src="vms.png">

## Container run time Engines 

<img src="cre.png">

## Docker installation history 

<img src="dinstall.png">

## Docker desktop link for Mac OS 

[docker desktop] ('https://hub.docker.com/editions/community/docker-ce-desktop-mac')

## Docker Desktop for Windows 10 

[docker desktop] ('https://hub.docker.com/editions/community/docker-ce-desktop-windows/')


## Docker Community Edition installation on Centos / OL 

```
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
====

sudo yum install docker-ce docker-ce-cli containerd.io

```

## Starting Docker in LInux Distribution 

```
   18  sudo systemctl start  docker 
   19  sudo systemctl status   docker 
   20  history 
[centos@ip-172-31-71-212 ~]$ sudo  docker  version  
Client: Docker Engine - Community
 Version:           19.03.13
 API version:       1.40
 Go version:        go1.13.15
 Git commit:        4484c46d9d
 Built:             Wed Sep 16 17:03:45 2020
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.13
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.13.15
  Git commit:       4484c46d9d
  Built:            Wed Sep 16 17:02:21 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.3.7
  GitCommit:        8fba4e9a7d01810a393d5d25a3621dc101981175
 runc:
  Version:          1.0.0-rc10
  GitCommit:        dc9208a3303feef5b3839f4323d9beb36df0a9dd
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683

```
