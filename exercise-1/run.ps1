Set-Location $PSScriptRoot
minikube start --driver=docker
kubectl get nodes
kubectl apply -f nginx-pod.yaml
kubectl wait --for=condition=Ready pod/nginx-pod --timeout=120s
kubectl get pods
kubectl expose pod nginx-pod --type=NodePort --port=80 --name=nginx-service
kubectl get services
Write-Host "`nOpening Nginx in the browser (keep this window open)..." -ForegroundColor Green
minikube service nginx-service
