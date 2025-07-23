#!/bin/bash

# Deployment script for QA environment
# Replace these values with your actual server details
SERVER="qa-server-ip-or-hostname"
USER="deploy-user"
APP_DIR="/var/www/qa.yourdomain.com"
REPO="https://github.com/yourusername/your-repo.git"
BRANCH="qa"

# Set environment variables
export FLASK_ENV=qa

# Create directory if it doesn't exist
ssh $USER@$SERVER "mkdir -p $APP_DIR"

# Clone or pull the repository
ssh $USER@$SERVER "
    if [ -d '$APP_DIR/.git' ]; then
        cd $APP_DIR
        git fetch origin
        git reset --hard origin/$BRANCH
    else
        git clone -b $BRANCH $REPO $APP_DIR
        cd $APP_DIR
    fi
"

# Install dependencies
ssh $USER@$SERVER "
    cd $APP_DIR
    python3 -m venv venv
    source venv/bin/activate
    pip install -r requirements.txt
"

# Restart the application (assuming you're using systemd)
# Uncomment and modify the following lines if you have a systemd service
# ssh $USER@$SERVER "sudo systemctl restart your-app-qa.service"

echo "Deployment to QA environment completed!"
