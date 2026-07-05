#!/bin/bash
set -ex

apt update -y

apt install -y python3 python3-pip python3-venv git

cd /home/ubuntu

git clone https://github.com/harshadapatil2603-art/TerraformAssignment.git

cd TerraformAssignment/tf2/backend

python3 -m venv venv

source venv/bin/activate

pip install -r requirements.txt

nohup python app.py > backend.log 2>&1 &