#!/bin/bash
# Deploy Kubernetes Learning Resources

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "=========================================="
echo "K8s Learning - Resource Deployment"
echo "=========================================="
echo ""

# Verify kubectl
if ! command -v kubectl &> /dev/null; then
    echo "❌ kubectl not found. Install kubectl first."
    exit 1
fi

echo "Current context: $(kubectl config current-context)"
echo ""

# Deploy in order (important!)
echo "Step 1️⃣  Creating Namespace..."
kubectl apply -f "$SCRIPT_DIR/1-namespace/"

echo ""
echo "Step 2️⃣  Creating ConfigMaps & Secrets..."
kubectl apply -f "$SCRIPT_DIR/2-configmap-secret/"

echo ""
echo "Step 3️⃣  Creating Deployments..."
kubectl apply -f "$SCRIPT_DIR/3-deployment/"

echo ""
echo "Step 4️⃣  Creating Services..."
kubectl apply -f "$SCRIPT_DIR/4-service/"

echo ""
echo "✅ Deployment Complete!"
echo ""

# Show resources
echo "📦 Resources Created:"
echo ""
echo "Namespace:"
kubectl get namespace learning
echo ""
echo "ConfigMaps:"
kubectl get configmap -n learning
echo ""
echo "Secrets:"
kubectl get secret -n learning
echo ""
echo "Deployments:"
kubectl get deployment -n learning
echo ""
echo "Pods:"
kubectl get pods -n learning
echo ""
echo "Services:"
kubectl get service -n learning
echo ""

echo "=========================================="
echo "Next Steps:"
echo "=========================================="
echo ""
echo "1. Check pod status:"
echo "   kubectl get pods -n learning -w"
echo ""
echo "2. View logs:"
echo "   kubectl logs -n learning deployment/nginx-app"
echo ""
echo "3. Port forward (nginx):"
echo "   kubectl port-forward -n learning svc/nginx-service 8080:80"
echo ""
echo "4. Port forward (python):"
echo "   kubectl port-forward -n learning svc/python-app-service 8000:8000"
echo ""
echo "5. Access shell in pod:"
echo "   kubectl exec -it -n learning deployment/nginx-app -- sh"
echo ""
echo "6. Describe resources:"
echo "   kubectl describe deployment nginx-app -n learning"
echo ""
echo "=========================================="
