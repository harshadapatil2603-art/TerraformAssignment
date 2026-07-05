#!/bin/bash

apt update -y

apt install -y python3 python3-pip git

cd /home/ubuntu

git clone https://github.com/harshadapatil2603-art/TerraformAssignment.git

cd TerraformAssignment/tf2/backend

pip3 install -r requirements.txt

nohup python3 app.py > backend.log 2>&1 &