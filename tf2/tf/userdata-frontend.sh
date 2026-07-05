#!/bin/bash

apt update -y

apt install -y nodejs npm git

cd /home/ubuntu

git clone https://github.com/harshadapatil2603-art/TerraformAssignment.git

cd TerraformAssignment/tf2/frontend

npm install

export BACKEND_URL=http://${backend_ip}:5000

nohup node app.js > frontend.log 2>&1 &