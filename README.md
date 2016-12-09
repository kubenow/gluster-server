# GlusterFS server
Docker-based GlusterFS server.

## Usage example on Kubernetes
Start by creating a `gluster.yml` file, defining a Service, a DaemonSet and a PersistentVolume:

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: gluster-server
spec:
  selector:
    k8s-app: gluster-server
  clusterIP: None
  ports:
  - name: dummy
    targetPort: 1
    port: 1

---
apiVersion: extensions/v1beta1
kind: DaemonSet
metadata:
  name: gluster-server
  namespace: default
  labels:
    k8s-app: gluster-server
    kubernetes.io/cluster-service: "true"
spec:
  selector:
    matchLabels:
      k8s-app: gluster-server
  template:
    metadata:
      labels:
        k8s-app: gluster-server
    spec:
      terminationGracePeriodSeconds: 60
      containers:
      - name: gluster-server
        image: kubenow/gluster-server
        imagePullPolicy: Always
        securityContext:
          privileged: true

---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: shared-volume
spec:
  capacity:
    storage: 10G
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  glusterfs:
    endpoints: gluster-server
    path: shared-volume
    readOnly: false
```

Then deploy GlusterFS and it's shared volume by running:

```bash
kubectl apply -f gluster.ym
```
