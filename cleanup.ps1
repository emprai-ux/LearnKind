# Cleanup Kubernetes Learning Resources (PowerShell)

$ErrorActionPreference = "Stop"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "K8s Learning - Cleanup" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Verify kubectl
if (-not (Get-Command kubectl -ErrorAction SilentlyContinue)) {
    Write-Host "❌ kubectl not found." -ForegroundColor Red
    exit 1
}

Write-Host "Current context: $(kubectl config current-context)" -ForegroundColor Yellow
Write-Host ""

$confirmation = Read-Host "Are you sure you want to delete the 'learning' namespace? (yes/no)"

if ($confirmation -eq "yes") {
    Write-Host "Deleting namespace 'learning'..." -ForegroundColor Yellow
    kubectl delete namespace learning
    Write-Host "✅ Cleanup Complete!" -ForegroundColor Green
} else {
    Write-Host "❌ Cleanup cancelled." -ForegroundColor Yellow
}
