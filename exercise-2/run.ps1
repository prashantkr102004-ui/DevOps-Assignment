Set-Location $PSScriptRoot
minikube start
minikube status
kubectl cluster-info
kubectl get nodes
docker build -t flask-app .
minikube image load flask-app:latest
kubectl apply -f flask-deployment.yaml
kubectl rollout status deployment/flask-app --timeout=120s
kubectl get deployments
kubectl get pods
$pod = kubectl get pods -l app=flask-app -o jsonpath='{.items[0].metadata.name}'
kubectl logs $pod
Write-Host "`nService URL (keep this window open, then run curl.exe <URL> in a new window):" -ForegroundColor Green
minikube service flask-app-service --url
