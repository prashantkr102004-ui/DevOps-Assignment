Set-Location $PSScriptRoot
minikube start --driver=docker
kubectl get nodes
Write-Host "Waiting for the cluster to be ready..." -ForegroundColor Yellow
kubectl wait --for=condition=Ready node --all --timeout=180s
while (-not (kubectl get serviceaccount default -o name 2>$null)) { Start-Sleep 2 }
kubectl delete service nginx-service --ignore-not-found
kubectl apply -f nginx-pod.yaml
kubectl wait --for=condition=Ready pod/nginx-pod --timeout=120s
kubectl get pods
kubectl expose pod nginx-pod --type=NodePort --port=80 --name=nginx-service
kubectl get services
Write-Host "`nOpening Nginx in the browser (keep this window open)..." -ForegroundColor Green
minikube service nginx-service
