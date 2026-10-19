Set-Location $PSScriptRoot
minikube start --nodes=3 -p devops-multinode
kubectl get nodes
Write-Host "Waiting for the cluster to be ready..." -ForegroundColor Yellow
kubectl wait --for=condition=Ready node --all --timeout=180s
while (-not (kubectl get serviceaccount default -o name 2>$null)) { Start-Sleep 2 }
docker build -t product-catalog:latest -f Dockerfile.product .
docker build -t shopping-cart:latest -f Dockerfile.shopping .
docker images | Select-String "product-catalog|shopping-cart"
minikube image load product-catalog:latest -p devops-multinode
minikube image load shopping-cart:latest -p devops-multinode
minikube image ls -p devops-multinode | Select-String "product-catalog|shopping-cart"
kubectl apply -f product_catalog_deployment.yaml
kubectl apply -f product_catalog_service.yaml
kubectl apply -f shopping_cart_deployment.yaml
kubectl apply -f shopping_cart_service.yaml
kubectl rollout status deployment/product-catalog --timeout=180s
kubectl rollout status deployment/shopping-cart --timeout=180s
kubectl get deployments
kubectl get replicasets
kubectl get pods -o wide
kubectl get services
kubectl get endpoints
Write-Host "`nNext: run 'minikube service product-catalog-service --url -p devops-multinode' and the curl commands in README.md" -ForegroundColor Green
