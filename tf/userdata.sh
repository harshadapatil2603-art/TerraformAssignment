#!/bin/bash

apt update -y

####################################
# Install Python
####################################

apt install python3 python3-pip python3-venv git -y

####################################
# Install NodeJS
####################################

curl -fsSL https://deb.nodesource.com/setup_20.x | bash -

apt install nodejs -y

####################################
# Clone Repository
####################################

cd /home/ubuntu

git clone https://github.com/USERNAME/YOUR-REPO.git

####################################
# Backend
####################################

cd YOUR-REPO/backend

python3 -m venv venv

source venv/bin/activate

pip install -r requirements.txt

cat <<EOF > .env
MONGO_URI=mongodb+srv://dummy:2630@cluster0.dyd41ym.mongodb.net/?appName=Cluster0
DB_NAME=todoDB
COLLECTION=todoItems
EOF

nohup python3 app.py > backend.log 2>&1 &

####################################
# Frontend
####################################

cd ../frontend

npm install

export BACKEND_URL=http://localhost:5000

nohup npm start > frontend.log 2>&1 &