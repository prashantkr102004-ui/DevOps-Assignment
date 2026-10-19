#!/bin/bash
# Exercise 5 - run inside Ubuntu (WSL):  bash run.sh
cd "$(dirname "$0")"
pause() { read -rp "$1 - take the screenshot, then press Enter... "; clear; }

echo "== Checking AppArmor =="
mountpoint -q /sys/kernel/security || sudo mount -t securityfs securityfs /sys/kernel/security
if [ "$(cat /sys/module/apparmor/parameters/enabled 2>/dev/null)" != "Y" ]; then
  echo "AppArmor is NOT enabled in WSL. Follow the setup steps first."; exit 1
fi

echo "== Installing Docker Engine and AppArmor tools (first time only) =="
if ! command -v apparmor_parser >/dev/null || ! sudo docker info >/dev/null 2>&1; then
  sudo apt-get update -y
  sudo apt-get install -y docker.io apparmor apparmor-utils python3-venv curl
  sudo service docker start
  sleep 3
fi
sudo docker rm -f flask-secure sdk-flask-secure >/dev/null 2>&1
clear

echo "\$ docker build -t flask-apparmor ."
sudo docker build -t flask-apparmor .
pause "Screenshot 1"

echo "\$ sudo apparmor_parser -r -W /etc/apparmor.d/docker-flask-apparmor"
sed 's/\r$//' docker-flask-apparmor | sudo tee /etc/apparmor.d/docker-flask-apparmor >/dev/null
sudo apparmor_parser -r -W /etc/apparmor.d/docker-flask-apparmor
echo "\$ sudo aa-status | grep docker-flask-apparmor"
sudo aa-status | grep docker-flask-apparmor
pause "Screenshot 2"

echo "\$ docker run -d --name flask-secure -p 5001:5000 --security-opt apparmor=docker-flask-apparmor flask-apparmor"
sudo docker run -d --name flask-secure -p 5001:5000 --security-opt apparmor=docker-flask-apparmor flask-apparmor
sleep 3
echo "\$ docker ps"
sudo docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
echo "\$ docker inspect flask-secure --format '{{.AppArmorProfile}}'"
sudo docker inspect flask-secure --format '{{.AppArmorProfile}}'
pause "Screenshot 3"

echo "\$ curl http://localhost:5001"
curl -s http://localhost:5001; echo
pause "Screenshot 4"

echo "\$ docker exec flask-secure cat /etc/shadow"
sudo docker exec flask-secure cat /etc/shadow
echo "\$ docker exec flask-secure touch /var/test.txt"
sudo docker exec flask-secure touch /var/test.txt
pause "Screenshot 5"

echo "\$ python docker_sdk.py"
[ -d ~/ex5-venv ] || python3 -m venv ~/ex5-venv
~/ex5-venv/bin/pip install -q docker
sudo ~/ex5-venv/bin/python docker_sdk.py
echo
echo "Done. Screenshot 6 now. Cleanup: sudo docker rm -f flask-secure sdk-flask-secure"
