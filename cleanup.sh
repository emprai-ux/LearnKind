#!/bin/bash
# Cleanup Kubernetes Learning Resources

set -e

echo "=========================================="
echo "K8s Learning - Cleanup"
echo "=========================================="
echo ""

# Verify kubectl
if ! command -v kubectl &> /dev/null; then
    echo "❌ kubectl not found."
    exit 1
fi

echo "Current context: $(kubectl config current-context)"
echo ""
read -p "Are you sure you want to delete the 'learning' namespace? (yes/no): " -r
echo ""

if [[ $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
    echo "Deleting namespace 'learning'..."
    kubectl delete namespace learning
    echo "✅ Cleanup Complete!"
else
    echo "❌ Cleanup cancelled."
fi
