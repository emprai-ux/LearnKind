# Kubernetes Quick Reference - Cheat Sheet

## 🚀 Common kubectl Commands

### Get Resources
```bash
kubectl get namespace                    # List namespaces
kubectl get pods -n learning             # List pods
kubectl get deployment -n learning       # List deployments
kubectl get service -n learning          # List services
kubectl get configmap -n learning        # List configmaps
kubectl get secret -n learning           # List secrets
kubectl get all -n learning              # List all resources
```

### Describe Resources (Detailed Info)
```bash
kubectl describe namespace learning
kubectl describe deployment nginx-app -n learning
kubectl describe pod <pod-name> -n learning
kubectl describe service nginx-service -n learning
kubectl describe configmap app-config -n learning
kubectl describe secret app-secrets -n learning
```

### Create/Update Resources
```bash
kubectl apply -f file.yaml               # Create or update
kubectl apply -f ./directory/            # Apply all files in directory
kubectl create -f file.yaml              # Create only (fails if exists)
```

### Delete Resources
```bash
kubectl delete pod <pod-name> -n learning
kubectl delete deployment nginx-app -n learning
kubectl delete service nginx-service -n learning
kubectl delete namespace learning        # Deletes all resources in namespace
```

### View Logs
```bash
kubectl logs deployment/nginx-app -n learning
kubectl logs pod/<pod-name> -n learning
kubectl logs -f deployment/nginx-app -n learning    # Follow/stream
kubectl logs --tail=10 deployment/nginx-app -n learning  # Last 10 lines
kubectl logs -p deployment/nginx-app -n learning    # Previous (if crashed)
```

### Execute Commands in Pods
```bash
kubectl exec -it deployment/nginx-app -n learning -- sh
kubectl exec -it pod/<pod-name> -n learning -- bash
kubectl exec deployment/nginx-app -n learning -- curl http://localhost
```

### Port Forwarding
```bash
kubectl port-forward -n learning svc/nginx-service 8080:80
kubectl port-forward -n learning pod/<pod-name> 8000:8000
```

### Watch Resources
```bash
kubectl get pods -n learning -w         # Watch pods
kubectl get deployment -n learning -w   # Watch deployments
```

### Scale Deployments
```bash
kubectl scale deployment nginx-app -n learning --replicas=3
```

### Update Deployment Image
```bash
kubectl set image deployment/nginx-app nginx=nginx:1.25-alpine -n learning
```

### View Resource YAML
```bash
kubectl get deployment nginx-app -n learning -o yaml
kubectl get configmap app-config -n learning -o yaml
```

---

## 🎯 Namespace Shortcuts

Always add `-n <namespace>` or `--namespace=<namespace>` to scope commands:

```bash
kubectl get pods -n learning
kubectl get pods --namespace learning
```

Set default namespace (avoid typing -n every time):
```bash
kubectl config set-context --current --namespace=learning
```

Switch back to default:
```bash
kubectl config set-context --current --namespace=default
```

---

## 📊 Output Formats

```bash
kubectl get pods -n learning -o wide         # More columns
kubectl get pods -n learning -o json         # JSON format
kubectl get pods -n learning -o yaml         # YAML format
kubectl get pods -n learning -o jsonpath='{.items[*].metadata.name}'  # Custom format
```

---

## 🏷️ Label and Selector Commands

```bash
# Get resources by label
kubectl get pods -n learning -l app=nginx-app
kubectl get pods -n learning -l environment=learning

# Show labels
kubectl get pods -n learning --show-labels

# Add label to running resource
kubectl label pod <pod-name> -n learning mylabel=myvalue

# Remove label
kubectl label pod <pod-name> -n learning mylabel-
```

---

## 🔍 Debugging & Troubleshooting

```bash
# Describe (most useful!)
kubectl describe pod <pod-name> -n learning

# Check events
kubectl get events -n learning

# View logs
kubectl logs deployment/nginx-app -n learning

# Check resource status
kubectl get pods -n learning -o wide

# Check resource usage
kubectl top pods -n learning
kubectl top nodes

# Debug pod connectivity
kubectl exec -it <pod-name> -n learning -- sh
# Inside pod: wget http://nginx-service:80

# Port forward to test
kubectl port-forward -n learning svc/nginx-service 8080:80
```

---

## 🛠️ Useful Shortcuts & Tips

### Create alias for shorter commands
```bash
# Bash
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgd='kubectl get deployment'
alias kgs='kubectl get service'

# Then use:
k get pods -n learning
```

### Common abbreviations (shortnames)
```bash
po   = pods
svc  = services
cm   = configmaps
sec  = secrets
dep  = deployments
ns   = namespaces
ev   = events
```

**Example:**
```bash
kubectl get svc -n learning              # Instead of service
kubectl get cm -n learning               # Instead of configmap
kubectl get sec -n learning              # Instead of secret
```

---

## 📋 Useful kubectl Flags

```bash
-n, --namespace=NAME         # Specify namespace
-o, --output=FORMAT          # Output format (yaml, json, wide, etc.)
-l, --selector=SELECTOR      # Filter by labels
-f, --filename=FILENAME      # File to apply
--all-namespaces             # All namespaces
-w, --watch                  # Watch for changes
-p, --previous               # Previous logs (crashed container)
-f, --follow                 # Follow/stream logs
--tail=N                     # Last N lines
--sort-by=FIELD              # Sort results
--show-labels                # Show labels
--recursive                  # Process directory recursively
```

---

## 🐛 Common Issues & Solutions

### Pod stuck in Pending
```bash
# Check what's wrong
kubectl describe pod <pod-name> -n learning

# Usually: insufficient resources, image pull issues, or PVC issues
```

### Image pull errors
```bash
# Check pod events
kubectl describe pod <pod-name> -n learning

# Might need image pull secret
# Or image name/tag is wrong
```

### Connection refused
```bash
# Check if pod is running
kubectl get pods -n learning

# Check if service selector matches pod labels
kubectl describe service nginx-service -n learning
kubectl get endpoints -n learning

# Test from another pod
kubectl exec -it <pod-name> -n learning -- sh
# Inside: curl http://service-name:port
```

### Cannot connect from outside
```bash
# For NodePort, must use node IP and nodePort
# kubectl get service shows the NodePort

# Port forward for local testing
kubectl port-forward svc/nginx-service 8080:80 -n learning

# Then: curl http://localhost:8080
```

---

## 📚 Resource Cheat Sheet

### Namespace
```bash
kubectl create namespace learning
kubectl delete namespace learning
kubectl get namespaces
kubectl describe namespace learning
```

### Deployment
```bash
kubectl create deployment nginx --image=nginx -n learning
kubectl get deployments -n learning
kubectl describe deployment nginx -n learning
kubectl delete deployment nginx -n learning
kubectl scale deployment nginx --replicas=3 -n learning
kubectl set image deployment/nginx nginx=nginx:1.25 -n learning
kubectl rollout history deployment/nginx -n learning
kubectl rollout undo deployment/nginx -n learning
```

### Service
```bash
kubectl expose deployment nginx --port=80 --target-port=80 --type=ClusterIP -n learning
kubectl get services -n learning
kubectl describe service nginx -n learning
kubectl delete service nginx -n learning
kubectl port-forward svc/nginx 8080:80 -n learning
```

### ConfigMap
```bash
kubectl create configmap app-config --from-literal=KEY=VALUE -n learning
kubectl create configmap app-config --from-file=config.yaml -n learning
kubectl get configmaps -n learning
kubectl describe configmap app-config -n learning
kubectl get configmap app-config -n learning -o yaml
kubectl delete configmap app-config -n learning
```

### Secret
```bash
kubectl create secret generic app-secrets --from-literal=DB_PASS=mypass -n learning
kubectl create secret docker-registry regcred --docker-server=... -n learning
kubectl get secrets -n learning
kubectl describe secret app-secrets -n learning
kubectl get secret app-secrets -n learning -o yaml
kubectl delete secret app-secrets -n learning
```

---

## 🔄 Workflow Example

```bash
# 1. Create namespace
kubectl create namespace learning

# 2. Create ConfigMap
kubectl create configmap app-config \
  --from-literal=LOG_LEVEL=INFO \
  -n learning

# 3. Create Secret
kubectl create secret generic app-secrets \
  --from-literal=DB_PASSWORD=secure123 \
  -n learning

# 4. Create Deployment
kubectl apply -f deployment.yaml -n learning

# 5. Create Service
kubectl apply -f service.yaml -n learning

# 6. Verify
kubectl get all -n learning

# 7. Test
kubectl port-forward svc/nginx-service 8080:80 -n learning
curl http://localhost:8080

# 8. Debug if needed
kubectl logs deployment/nginx-app -n learning
kubectl describe pod <pod-name> -n learning

# 9. Cleanup
kubectl delete namespace learning
```

---

## 🎓 Learning Path

1. **Namespace** - Understand resource isolation
2. **Deployment** - Create and manage pods
3. **Service** - Expose and access applications
4. **ConfigMap** - Manage configuration
5. **Secret** - Handle sensitive data
6. **Probes** - Health checks and rolling updates
7. **Resources** - CPU and memory management
8. **Labels** - Organize and select resources

---

**Pro Tips:**
- Use `kubectl explain <resource>` for documentation
- Use `kubectl api-resources` to see all resource types
- Use `--dry-run=client -o yaml` to preview what kubectl will do
- Always use descriptive names for resources
- Use labels consistently for organization
- Keep resource YAML files in version control

