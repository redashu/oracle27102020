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


