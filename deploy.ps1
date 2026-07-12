# Deploy Kubernetes Learning Resources (PowerShell)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "K8s Learning - Resource Deployment" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Verify kubectl
if (-not (Get-Command kubectl -ErrorAction SilentlyContinue)) {
    Write-Host "❌ kubectl not found. Install kubectl first." -ForegroundColor Red
    exit 1
}

Write-Host "Current context: $(kubectl config current-context)" -ForegroundColor Yellow
Write-Host ""

# Deploy in order (important!)
Write-Host "Step 1️⃣  Creating Namespace..." -ForegroundColor Green
kubectl apply -f "$ScriptDir\1-namespace\"

Write-Host ""
Write-Host "Step 2️⃣  Creating ConfigMaps & Secrets..." -ForegroundColor Green
kubectl apply -f "$ScriptDir\2-configmap-secret\"

Write-Host ""
Write-Host "Step 3️⃣  Creating Deployments..." -ForegroundColor Green
kubectl apply -f "$ScriptDir\3-deployment\"

Write-Host ""
Write-Host "Step 4️⃣  Creating Services..." -ForegroundColor Green
kubectl apply -f "$ScriptDir\4-service\"

Write-Host ""
Write-Host "✅ Deployment Complete!" -ForegroundColor Green
Write-Host ""

# Show resources
Write-Host "📦 Resources Created:" -ForegroundColor Yellow
Write-Host ""
Write-Host "Namespace:" -ForegroundColor Cyan
kubectl get namespace learning

Write-Host ""
Write-Host "ConfigMaps:" -ForegroundColor Cyan
kubectl get configmap -n learning

Write-Host ""
Write-Host "Secrets:" -ForegroundColor Cyan
kubectl get secret -n learning

Write-Host ""
Write-Host "Deployments:" -ForegroundColor Cyan
kubectl get deployment -n learning

Write-Host ""
Write-Host "Pods:" -ForegroundColor Cyan
kubectl get pods -n learning

Write-Host ""
Write-Host "Services:" -ForegroundColor Cyan
kubectl get service -n learning

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Check pod status:" -ForegroundColor Yellow
Write-Host "   kubectl get pods -n learning -w" -ForegroundColor White
Write-Host ""
Write-Host "2. View logs:" -ForegroundColor Yellow
Write-Host "   kubectl logs -n learning deployment/nginx-app" -ForegroundColor White
Write-Host ""
Write-Host "3. Port forward (nginx):" -ForegroundColor Yellow
Write-Host "   kubectl port-forward -n learning svc/nginx-service 8080:80" -ForegroundColor White
Write-Host ""
Write-Host "4. Port forward (python):" -ForegroundColor Yellow
Write-Host "   kubectl port-forward -n learning svc/python-app-service 8000:8000" -ForegroundColor White
Write-Host ""
Write-Host "5. Access shell in pod:" -ForegroundColor Yellow
Write-Host "   kubectl exec -it -n learning deployment/nginx-app -- sh" -ForegroundColor White
Write-Host ""
Write-Host "6. Describe resources:" -ForegroundColor Yellow
Write-Host "   kubectl describe deployment nginx-app -n learning" -ForegroundColor White
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
