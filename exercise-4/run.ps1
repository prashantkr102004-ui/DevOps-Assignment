Set-Location $PSScriptRoot
docker network create my-bridge-net
docker network ls
docker build -t flask-api .
docker run -d --name mysql --network my-bridge-net -e MYSQL_ROOT_PASSWORD=rootpass -e MYSQL_DATABASE=devopsdb mysql:8.0
docker run -d --name redis --network my-bridge-net redis:latest
docker run -d --name flask-api --network my-bridge-net -p 5001:5001 flask-api
docker ps
Start-Sleep 5
curl.exe http://localhost:5001/about
docker exec flask-api python -c "import socket; print('mysql ->', socket.gethostbyname('mysql')); print('redis ->', socket.gethostbyname('redis'))"
docker exec redis redis-cli ping
Write-Host "Waiting 30s for MySQL to initialise..." -ForegroundColor Yellow
Start-Sleep 30
docker exec mysql mysql -uroot -prootpass -e "SHOW DATABASES;"
