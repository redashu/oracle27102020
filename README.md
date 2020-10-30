# Day 4 

<img src="final.png">

## creating POD

```
kubectl  run ashupod001  --image=dockerashu/httpd:ashuappv2  --port 80 --dry-run=client -o yaml  >http.yml
```

## SErvice concept with labels 

<img src="label.png">

## checking labels 

```
 kubectl get  po  --show-labels
NAME           READY   STATUS    RESTARTS   AGE     LABELS
ashupod001     1/1     Running   0          12m     run=ashupod001
ashutosh       1/1     Running   0          30m     run=ashutosh
gknginx1       1/1     Running   0          30m     run=gknginx1
himanshup02    1/1     Running   0          22m     run=himanshup02
navneeth       1/1     Running   0          31m     run=navneeth
prasadpod004   1/1     Running   0          21m     run=prasadpod004
prd001         1/1     Running   0          30m     run=prd001
rati1          1/1     Running   0          21m     run=rati1
sahttpd01      1/1     Running   0          27m     run=sahttpd01
saurav001      1/1     Running   0          20m     run=saurav001
sravan0022     1/1     Running   0          3m54s   run=sravan0022

```

## service overview 

<img src="service.png">


## Nodeport with Minion 

<img src="nodep1.png">

## Nodeport with multi Minion 

<img src="nodep2.png">

## creating a service 

```
kubectl  create  service  nodeport  ashus11  --tcp  1234:80  --dry-run=client -o yaml
```

## matching the label of POD

```
❯ cat  ashus1.yml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:  # label of  service 
    app: ashus11
  name: ashus11  # name of service 
spec:
  ports:
  - name: 1234-80
    port: 1234   #  service port that will be binded with service IP 
    protocol: TCP
    targetPort: 80 #  target POD port 
  selector:  # will be used to find / search pod with given labels 
   run: ashupod001   # same as label of POD
  type: NodePort   # type of servcie 
  
  ```
  
  
  ##  merge POd / service 
  
  ```
  ❯ kubectl  create  service  nodeport  ashus11  --tcp  1234:80  --dry-run=client -o yaml  >>http.yml
❯ vim  http.yml
❯ kubectl apply -f http.yml
pod/ashupod001 created
service/ashus11 created
❯ kubectl get  po,svc
NAME             READY   STATUS    RESTARTS   AGE
pod/ashupod001   1/1     Running   0          8s
pod/gknginx1     1/1     Running   0          31s
pod/sahttpd01    1/1     Running   0          6s

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/ashus11      NodePort    10.97.94.85     <none>        1234:31887/TCP   8s
service/gknginx1s    NodePort    10.104.46.210   <none>        1440:31440/TCP   31s
service/kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP          4m11s
service/saser01      NodePort    10.96.6.206     <none>        7234:30837/TCP   6s

```

## 

```
❯ cat http.yml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: ashupod001
  name: ashupod001
spec:
  containers:
  - image: dockerashu/httpd:ashuappv2
    name: ashupod001
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

---

apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: ashus11
  name: ashus11
spec:
  ports:
  - name: 1234-80
    port: 1234
    protocol: TCP
    targetPort: 80
  selector:
   run: ashupod001  
  type: NodePort
  
 ```
 
# RC 

```
❯ cat ashuapp-rc.yml
apiVersion: v1
kind: ReplicationController
metadata:
 name: ashu-rc-1
 labels:
  x: ashurc

spec:
 replicas: 2  # number of PODS 
 template:  # rc will use template to create pods 
  metadata:
   labels:  # label of pod 
    app: ashuapprc
  spec:
   containers:
   - image: dockerashu/httpd:ashuappv2
     name: ashuc1
     ports:
     - containerPort: 80
     
 ```
 
 ##  Scale 
 
 ```
 985  kubectl  scale  rc  ashu-rc-1  --replicas=1  
  986  kubectl get  rc
  987  kubectl  scale  rc  ashu-rc-1  --replicas=10  
  988  kubectl get  rc
❯ kubectl  scale  rc  ashu-rc-1  --replicas=2
replicationcontroller/ashu-rc-1 scaled

```

## Deployment in k8s

<img src="dep.png">

## creating deployment 

```
kubectl  create deployment  ashudep1 --image=nginx  --dry-run=client -o yaml  >ashudep.yml
```

## Deployment commands 

```
❯ kubectl  apply -f  ashudep.yml
deployment.apps/ashudep1 created
❯ 
❯ kubectl get  rs
NAME                  DESIRED   CURRENT   READY   AGE
ashudep1-6866c5cf89   1         1         1       6s
❯ kubectl get  po
NAME                        READY   STATUS    RESTARTS   AGE
ashudep1-6866c5cf89-5fnbr   1/1     Running   0          9s
❯ 
❯ kubectl get  deploy
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
ashudep1       1/1     1            1           18s
ashutoshdep1   1/1     1            1           2s
❯ kubectl get  rs
NAME                      DESIRED   CURRENT   READY   AGE
ashudep1-6866c5cf89       1         1         1       22s
ashutoshdep1-5c7659b5bc   1         1         1       6s
❯ kubectl get  po
NAME                            READY   STATUS    RESTARTS   AGE
ashudep1-6866c5cf89-5fnbr       1/1     Running   0          25s
ashutoshdep1-5c7659b5bc-nwj8c   1/1     Running   0          9s
```

## namespace

```
❯ kubectl get  namespace
NAME              STATUS   AGE
default           Active   30h
kube-node-lease   Active   30h
kube-public       Active   30h
kube-system       Active   30h
rati              Active   22h
❯ kubectl  create  namespace  ashu-space
namespace/ashu-space created
❯ kubectl get  namespace
NAME              STATUS   AGE
ashu-space        Active   4s
default           Active   30h
kube-node-lease   Active   30h
kube-public       Active   30h
kube-system       Active   30h
rati              Active   22h

```


## check version upgrade

```
 kubectl  create deployment  ashuapp123 --image=dockerashu/oraclewebapp:v0001  --dry-run=client -o yaml >appde.yml
 
 ===
 ❯ cat  appde.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: ashu-space
  creationTimestamp: null
  labels:
    app: ashuapp123
  name: ashuapp123
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ashuapp123
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: ashuapp123
    spec:
      containers:
      - image: dockerashu/oraclewebapp:v0001
        name: oraclewebapp
        resources: {}
        
  ```
  
  ## depoy
  
  ```
   1040  kubectl  expose deployment  ashuapp123  --type NodePort --port 9090 --target-port 80  --name  mysvc1  -n ashu-space 
 1041  kubectl  get  svc  -n ashu-space
 1042  kubectl  get  po  -n ashu-space
 1043  kubectl  get  deployment  -n ashu-space 
 1044  kubectl  get  rs   -n ashu-space 
 1045  kubectl  get  po  -n ashu-space 
❯ kubectl  get svc   -n ashu-space
NAME     TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
mysvc1   NodePort   10.106.229.57   <none>        9090:30881/TCP   4m3s

```

## scaling 

```
❯ kubectl  get  deploy -n ashu-space
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
ashuapp123   1/1     1            1           10m
❯ 
❯ kubectl scale deployment  ashuapp123 --replicas=5 -n ashu-space
deployment.apps/ashuapp123 scaled
❯ 
❯ kubectl  get  deploy -n ashu-space
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
ashuapp123   5/5     5            5           11m

```
## Describe k8s deployment 

```
❯ kubectl describe deploy ashuapp123  -n ashu-space
Name:                   ashuapp123
Namespace:              ashu-space
CreationTimestamp:      Fri, 30 Oct 2020 14:59:19 +0530
Labels:                 app=ashuapp123
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=ashuapp123
Replicas:               5 desired | 5 updated | 5 total | 5 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=ashuapp123
  Containers:
   oraclewebapp:
    Image:        dockerashu/oraclewebapp:v0001
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:

```

## check version history 

```
❯ kubectl rollout history deploy  ashuapp123  -n ashu-space
deployment.apps/ashuapp123 
REVISION  CHANGE-CAUSE
1         <none>
2         <none>
3         <none>


░▒▓ ~/Desktop/mypods ··

```

 ## rollback to prevsion 
 
 ```
 1073  kubectl rollout history deploy  ashuapp123  -n ashu-space 
 1074  kubectl rollout undo  deploy  ashuapp123  --to-revision=1   -n ashu-space 
 1075  kubectl rollout status deploy  ashuapp123  -n ashu-space
 
 ```
 
 ## end user to pod 
 
 <img src="eupod.png">
 
 
# storage 

<img src="st.png">

## EmptyDir 
```
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: ashualppod001
  name: ashualppod001
spec:
  volumes:   #  for volume creation purpose 
  - name: ashuvol001 
    emptyDir: {}   #  will take some random location from selected minion Node 
  containers:
  - image: alpine
    name: ashualppod001
    volumeMounts:
    - name: ashuvol001
      mountPath: /mnt/oracledata 
    command: ["/bin/sh","-c","ping fb.com -i 2 >>/mnt/oracledata/data.txt"]  # replace of Entrypoint
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  
  ```
  
## Emp with HostPath

```
❯ cat  alp.yml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: ashualppod001
  name: ashualppod001
spec:
  volumes:   #  for volume creation purpose 
  - name: ashuvol001 
    emptyDir: {}   #  will take some random location from selected minion Node 

  - name: ashuvol002
    hostPath:  # it will take directory / file from minion node
     path: /etc
     type: Directory 
     
  containers:
  - image: alpine
    name: ashualppod001
    volumeMounts:
    - name: ashuvol001
      mountPath: /mnt/oracledata 
    - name: ashuvol002
      mountPath: /myhostetc  # mount point in the POD/container 
    command: ["/bin/sh","-c","ping fb.com -i 2 >>/mnt/oracledata/data.txt"]  # replace of Entrypoint 
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  
  ```
  
  
# Dashbaord 

<img src="sacc.png">

## 

```
❯ kubectl get  serviceaccount  -n  ashu-space
NAME      SECRETS   AGE
default   1         133m
❯ kubectl get  sa  -n  ashu-space
NAME      SECRETS   AGE
default   1         133m
❯ kubectl get  secret   -n  ashu-space
NAME                  TYPE                                  DATA   AGE
default-token-pqtdx   kubernetes.io/service-account-token   3      134m
❯ kubectl describe   secret  default-token-pqtdx  -n  ashu-space
Name:         default-token-pqtdx
Namespace:    ashu-space
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: default
              kubernetes.io/service-account.uid: 9700cfd1-a646-4e02-9ed9-de56700faff1

Type:  kubernetes.io/service-account-token

Data
====
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6Ind2Vk0xbERqanhOOFpxU0RGMlFXSi1rb2RoT1VNLVdIRjUtNEcxOXZLTXcifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJhc2h1LXNwYWNlIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRlZmF1bHQtdG9rZW4tcHF0ZHgiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6Ijk3MDBjZmQxLWE2NDYtNGUwMi05ZWQ5LWRlNTY3MDBmYWZmMSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDphc2h1LXNwYWNlOmRlZmF1bHQifQ.Vjv-jVkKjWc9ZnaoCPR-IbueTerUpgcnjbtWbCkdkjwS509kp5koNZ2PB_64sDiI8wNyZ8RUN15MJbaOwIdaZf4ALTCF-KoHCSoAKQ7MuOJZfcsOEikArFgisZh5oQ_jkGN9XAUfrd4-heyOswcieYTGpzxjmhfoWT68eMl3LrxFUhJYv-2KXXW5-9b23tdwT1hGAWcISFmwaeILu8WEOIirdhNwYFTc1fkKMAgKxkbXKOe-eyJBYeTCZfgiarj7rImP0VE8a4-NDVhsoVS5jkkRMRN45sJ7lJw-LbrQwvvYpdYuveck57YCCpnr5QFF04A9DjRwSQIvEepAvTBTSg
ca.crt:     1066 bytes
namespace:  10 bytes
```

# Deploy dashboard 

```
1110  kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
 1111  kubectl get  ns
 1112  kubectl get po -n kubernetes-dashbarod
 1113  kubectl get po -n kubernetes-dashboard 
 1114  kubectl get sa  -n kubernetes-dashboard 
 1115  kubectl get secret  -n kubernetes-dashboard 
 1116  kubectl describe secret kubernetes-dashboard-token-hbv5x   -n kubernetes-dashboard 
 1117  history
 1118  kubectl get po -n kubernetes-dashboard 
 1119  kubectl get svc  -n kubernetes-dashboard 
 1120  kubectl edit  svc  kubernetes-dashboard   -n kubernetes-dashboard 
 1121  kubectl get svc  -n kubernetes-dashboard 
 
 ```
 
 ## dashboard link
 
 [dashboard] ('https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/')
 
 
