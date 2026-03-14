#!/bin/bash

# Update system
yum update -y
yum install -y git

# Run everything as ec2-user
su - ec2-user << 'EOF'

# Install NVM
export NVM_DIR="$HOME/.nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# Load nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node LTS
nvm install --lts
nvm alias default 'lts/*'
nvm use --lts

# Create app directory
mkdir -p ~/app
cd ~/app

# Create Express app
cat << 'APP' > index.js
const express = require('express');
const app = express();
const port = 3000;

app.get('/api', (req, res) => {
  res.send('Hello World from Express.js on private EC2! udpated to ec-2 user');
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});
APP

# Initialize project
npm init -y
npm install express

# Start app
nohup node index.js > app.log 2>&1 &

EOF
