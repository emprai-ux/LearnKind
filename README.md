# Kubernetes Learning Guide - Separate Resource Files

A well-organized learning environment with separate files for each Kubernetes resource type. This structure follows best practices and helps understand how different resources work together.

## 📁 Directory Structure

```
k8s-learning/
├── 1-namespace/
│   └── namespace.yaml          # Namespace definition
├── 2-configmap-secret/
│   ├── configmap.yaml         # Configuration data
│   └── secret.yaml            # Sensitive data
├── 3-deployment/
│   ├── deployment-nginx.yaml  # Nginx deployment
│   └── deployment-simple-python.yaml  # Python app
├── 4-service/
│   ├── service-clusterip.yaml     # Internal service
│   ├── service-nodeport.yaml      # External service
│   └── service-python-app.yaml    # Python app services
├── deploy.sh                   # Bash deployment script
├── deploy.ps1                  # PowerShell deployment script
├── cleanup.sh                  # Bash cleanup script
├── cleanup.ps1                 # PowerShell cleanup script
└── README.md                   # This file
```

## 🎯 Deployment Order

**Important:** Deploy resources in this order (dependencies):

1. **Namespace** - Container for all resources
2. **ConfigMap & Secrets** - Referenced by deployments
3. **Deployment** - Uses ConfigMap/Secrets
4. **Service** - Routes to deployments

## 📝 Resource Types Explained

### 1. Namespace (`1-namespace/namespace.yaml`)

**What it is:** A virtual cluster to organize and isolate resources

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: learning
```

**Why use it:**
- Logical organization
- Access control
- Resource quotas
- Avoiding naming conflicts

**Common commands:**
```bash
kubectl get namespaces
kubectl describe namespace learning
kubectl get pods --namespace learning
kubectl get pods -n learning        # Short form
```

---

### 2. ConfigMap (`2-configmap-secret/configmap.yaml`)

**What it is:** Store non-sensitive configuration data

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  APP_NAME: "HelloApp"
  LOG_LEVEL: "INFO"
```

**Key Characteristics:**
- Plain text, base64 NOT used
- Up to ~1MB per ConfigMap
- Can contain complete files
- NOT for passwords/tokens

**Ways to use in pods:**
```yaml
envFrom:
  - configMapRef:
      name: app-config           # All keys as env vars

env:
- name: LOG_LEVEL
  valueFrom:
    configMapKeyRef:
      name: app-config
      key: LOG_LEVEL             # Single key as env var

volumeMounts:
- name: config-volume
  mountPath: /etc/config/
  
volumes:
- name: config-volume
  configMap:
    name: app-config             # Mount as files
```

**Common commands:**
```bash
kubectl get configmap -n learning
kubectl describe configmap app-config -n learning
kubectl get configmap app-config -n learning -o yaml
```

---

### 3. Secret (`2-configmap-secret/secret.yaml`)

**What it is:** Store sensitive data (passwords, tokens, keys)

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
type: Opaque
stringData:
  DATABASE_PASSWORD: "SecurePass123"
  API_KEY: "sk_live_abc123"
```

**⚠️ IMPORTANT:**
- Base64 encoded by DEFAULT (not encrypted!)
- For production: use external secret management
- Types: Opaque, kubernetes.io/tls, kubernetes.io/dockercfg

**Secret Types:**
```yaml
# 1. Opaque (generic key-value)
type: Opaque

# 2. Docker Registry Credentials
type: kubernetes.io/dockercfg

# 3. TLS/SSL Certificate
type: kubernetes.io/tls
```

**Common commands:**
```bash
kubectl get secret -n learning
kubectl describe secret app-secrets -n learning
kubectl get secret app-secrets -n learning -o yaml  # WARNING: Shows decoded!
```

**Decode a secret value:**
```bash
kubectl get secret app-secrets -n learning -o jsonpath='{.data.DATABASE_PASSWORD}' | base64 -d
```

---

### 4. Deployment (`3-deployment/deployment-*.yaml`)

**What it is:** Manages replicated pods with updates and rollbacks

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-app
spec:
  replicas: 2              # Number of pods
  selector:
    matchLabels:
      app: nginx-app       # Find pods with this label
  template:
    # Pod specification...
```

**Key Concepts:**

#### Replicas
```yaml
replicas: 2  # Keep 2 copies running
```
- Self-healing: If a pod dies, deployment creates new one
- Load balancing: Multiple pods for availability

#### Selectors and Labels
```yaml
selector:
  matchLabels:
    app: nginx-app

template:
  metadata:
    labels:
      app: nginx-app  # Must match selector!
```

#### Container Specification
```yaml
containers:
- name: nginx
  image: nginx:1.24-alpine
  ports:
  - containerPort: 80
```

#### Resource Requests and Limits
```yaml
resources:
  requests:           # Minimum guaranteed
    memory: "64Mi"
    cpu: "100m"       # 100 millicores = 0.1 CPU
  limits:             # Maximum allowed
    memory: "128Mi"
    cpu: "200m"
```

**CPU Units:**
- 1 = 1000m (millicores)
- 100m = 0.1 CPU
- 250m = 0.25 CPU

**Memory Units:**
- 1Mi = 1,048,576 bytes (mebibyte)
- 1Gi = 1,073,741,824 bytes (gibibyte)
- 64Mi ≈ 67MB

#### Probes (Health Checks)

**Liveness Probe** - Is the container alive?
```yaml
livenessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 10  # Wait before first check
  periodSeconds: 10        # Check every 10s
  failureThreshold: 3      # Restart after 3 failures
```

**Readiness Probe** - Is the container ready for traffic?
```yaml
readinessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 5
  periodSeconds: 5
```

#### Environment Variables

From ConfigMap:
```yaml
envFrom:
- configMapRef:
    name: app-config          # All keys injected
```

From Secret:
```yaml
envFrom:
- secretRef:
    name: app-secrets         # All keys injected
```

Specific value:
```yaml
env:
- name: LOG_LEVEL
  valueFrom:
    configMapKeyRef:
      name: app-config
      key: LOG_LEVEL
```

**Common commands:**
```bash
kubectl get deployment -n learning
kubectl describe deployment nginx-app -n learning
kubectl get pods -n learning                    # See created pods
kubectl logs -n learning deployment/nginx-app  # View logs
kubectl logs -n learning pod-name -f           # Follow logs
kubectl set image -n learning deployment/nginx-app nginx=nginx:1.25-alpine  # Update image
kubectl rollout history -n learning deployment/nginx-app
kubectl rollout undo -n learning deployment/nginx-app  # Rollback
```

---

### 5. Service (`4-service/service-*.yaml`)

**What it is:** Stable network endpoint for accessing pods

**Problem it solves:**
- Pods are ephemeral (created/destroyed frequently)
- Need stable IP/DNS for external access
- Load balance traffic across pod replicas

#### Service Types

**ClusterIP (Default)**
```yaml
type: ClusterIP
selector:
  app: nginx-app
ports:
- port: 80
  targetPort: 80
```
- Internal only
- Accessible from within cluster
- DNS: `service-name.namespace.svc.cluster.local`
- Use for: internal service-to-service communication

**NodePort**
```yaml
type: NodePort
ports:
- port: 80
  targetPort: 80
  nodePort: 30080        # Port on each node (30000-32767)
```
- External access
- Accessible from outside cluster
- URL: `http://node-ip:30080`
- Use for: direct external access to services

**LoadBalancer**
```yaml
type: LoadBalancer
ports:
- port: 80
  targetPort: 80
```
- External load balancer integration
- Assigns external IP
- Use for: cloud environments (AWS, GCP, Azure)

#### Service Discovery

**Within cluster (ClusterIP):**
```
http://nginx-service.learning.svc.cluster.local:80
http://nginx-service:80                         # From same namespace
```

**Outside cluster (NodePort):**
```
http://192.168.1.100:30080                      # Node IP:NodePort
http://localhost:30080                          # From localhost
```

**Common commands:**
```bash
kubectl get service -n learning
kubectl describe service nginx-service -n learning
kubectl get endpoints -n learning nginx-service  # See pod IPs
kubectl port-forward -n learning svc/nginx-service 8080:80  # Local access
```

---

## 🚀 Quick Start

### Deploy all resources:

**PowerShell (Windows):**
```powershell
cd k8s-learning
./deploy.ps1
```

**Bash (Linux/Mac):**
```bash
cd k8s-learning
chmod +x deploy.sh
./deploy.sh
```

**Manual deployment:**
```bash
# Deploy resources in order
kubectl apply -f 1-namespace/
kubectl apply -f 2-configmap-secret/
kubectl apply -f 3-deployment/
kubectl apply -f 4-service/

# Or all at once (depends on deployment controller)
kubectl apply -f .
```

---

## 📊 Verifying Deployment

```bash
# Check namespace
kubectl get namespace learning

# Check all resources in namespace
kubectl get all -n learning

# Detailed view
kubectl describe namespace learning
kubectl describe deployment nginx-app -n learning
kubectl describe service nginx-service -n learning

# Pod details
kubectl get pods -n learning -o wide

# Watch pods starting
kubectl get pods -n learning -w
```

---

## 🔌 Accessing Applications

### Nginx App

**Internal access (from another pod):**
```bash
curl http://nginx-service.learning.svc.cluster.local
```

**External access (NodePort):**
```bash
# From outside cluster
curl http://<node-ip>:30080

# From localhost (if running Kind locally)
curl http://localhost:30080
```

**Port forward (best for local development):**
```bash
kubectl port-forward -n learning svc/nginx-service 8080:80
# Then: http://localhost:8080
```

### Python App

**Internal access:**
```bash
curl http://python-app-service.learning.svc.cluster.local:8000
```

**External access (NodePort):**
```bash
curl http://localhost:30081
```

**Port forward:**
```bash
kubectl port-forward -n learning svc/python-app-service 8000:8000
```

---

## 🐚 Accessing Pod Shell

```bash
# Get pod name
kubectl get pods -n learning

# Access shell
kubectl exec -it -n learning deployment/nginx-app -- sh
kubectl exec -it -n learning deployment/python-app -- bash

# Run single command
kubectl exec -n learning deployment/nginx-app -- curl http://localhost
```

---

## 📝 Viewing Logs

```bash
# Get logs from deployment
kubectl logs -n learning deployment/nginx-app

# Get logs from specific pod
kubectl logs -n learning nginx-app-abc123

# Stream logs (follow)
kubectl logs -n learning deployment/nginx-app -f

# Get logs from multiple pods
kubectl logs -n learning -l app=nginx-app

# Get previous logs (if container crashed)
kubectl logs -n learning deployment/nginx-app --previous
```

---

## 🔍 Debugging Commands

```bash
# Describe resource (very useful!)
kubectl describe deployment nginx-app -n learning
kubectl describe pod nginx-app-abc123 -n learning
kubectl describe service nginx-service -n learning

# Get events (what happened)
kubectl get events -n learning
kubectl get events -n learning --sort-by=.metadata.creationTimestamp

# Check ConfigMap data
kubectl get configmap app-config -n learning -o yaml

# Check Secret data (decoded!)
kubectl get secret app-secrets -n learning -o yaml

# Get resource YAML
kubectl get deployment nginx-app -n learning -o yaml

# Check resource health
kubectl get pods -n learning -o wide
kubectl top nodes
kubectl top pods -n learning
```

---

## 🧪 Learning Exercises

### Exercise 1: Scale the deployment
```bash
# Current replicas
kubectl get deployment nginx-app -n learning

# Scale to 3 replicas
kubectl scale deployment nginx-app -n learning --replicas=3

# Watch pods being created
kubectl get pods -n learning -w

# Scale back to 1
kubectl scale deployment nginx-app -n learning --replicas=1
```

### Exercise 2: Update the image
```bash
# Update nginx version
kubectl set image deployment/nginx-app nginx=nginx:1.25-alpine -n learning

# Watch the rolling update
kubectl get pods -n learning -w

# Check deployment status
kubectl describe deployment nginx-app -n learning
```

### Exercise 3: Test ConfigMap usage
```bash
# Get pod name
POD=$(kubectl get pod -n learning -l app=nginx-app -o jsonpath='{.items[0].metadata.name}')

# Check env vars from ConfigMap
kubectl exec -n learning $POD -- env | grep APP
```

### Exercise 4: Port forward and test
```bash
# Terminal 1: Port forward
kubectl port-forward -n learning svc/nginx-service 8080:80

# Terminal 2: Test
curl http://localhost:8080
```

---

## 🗑️ Cleanup

### Delete specific resource:
```bash
kubectl delete deployment nginx-app -n learning
kubectl delete service nginx-service -n learning
kubectl delete configmap app-config -n learning
kubectl delete secret app-secrets -n learning
```

### Delete everything:

**PowerShell:**
```powershell
./cleanup.ps1
```

**Bash:**
```bash
./cleanup.sh
```

**Manual:**
```bash
kubectl delete namespace learning
```

---

## 📚 Key Concepts Summary

| Concept | Purpose | Location |
|---------|---------|----------|
| **Namespace** | Organize & isolate resources | `1-namespace/` |
| **ConfigMap** | Non-sensitive config | `2-configmap-secret/` |
| **Secret** | Sensitive data | `2-configmap-secret/` |
| **Deployment** | Manage pod replicas | `3-deployment/` |
| **Pod** | Single container instance | Created by Deployment |
| **Service** | Network endpoint | `4-service/` |
| **Label** | Identify resources | In metadata |
| **Selector** | Find resources by label | In spec |
| **Probe** | Health check | In container spec |
| **Resource** | CPU/Memory allocation | In container spec |

---

## 🔗 Related Resources

- [Kubernetes Official Documentation](https://kubernetes.io/docs/)
- [Kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [Kind Cluster Documentation](https://kind.sigs.k8s.io/)
- [Kubernetes Best Practices](https://kubernetes.io/docs/concepts/configuration/overview/)

---

## 💡 Learning Tips

1. **Start simple** - Understand each file before combining
2. **Use `describe`** - Most useful debugging command
3. **Check labels** - Understand selector matching
4. **Watch deployments** - See real-time changes with `-w` flag
5. **Read logs** - First place to look for errors
6. **Save YAML** - Keep versions of what you deploy
7. **Test locally** - Use port-forward before deploying

---

**Created:** 2026-07-12  
**Purpose:** Learning and experimentation with Kubernetes
