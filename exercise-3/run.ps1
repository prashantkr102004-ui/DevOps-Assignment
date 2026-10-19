Set-Location $PSScriptRoot
minikube start --nodes=1
kubectl get nodes
Write-Host "Waiting for the cluster to be ready..." -ForegroundColor Yellow
kubectl wait --for=condition=Ready node --all --timeout=180s
while (-not (kubectl get serviceaccount default -o name 2>$null)) { Start-Sleep 2 }
docker build -t flashsale:1.1 .
minikube image load flashsale:1.1
kubectl apply -f flashsale-replicaset.yaml
Start-Sleep 20
kubectl get rs
Read-Host "Screenshot 02 taken? Press Enter to scale to 5"
kubectl scale rs flashsale-rs --replicas=5
Start-Sleep 20
kubectl get rs
kubectl get pods -l app=flashsale
kubectl get pods -l app=flashsale -o wide
Read-Host "Screenshots 03-05 taken? Press Enter to delete one pod"
$pod = kubectl get pods -l app=flashsale -o jsonpath='{.items[0].metadata.name}'
kubectl delete pod $pod
kubectl get pods -l app=flashsale
Start-Sleep 20
kubectl get pods -l app=flashsale -o wide
