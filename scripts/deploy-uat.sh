#!/bin/bash

# Deployment script for UAT environment
# Replace these values with your actual server details
SERVER="uat-server-ip-or-hostname"
USER="deploy-user"
APP_DIR="/var/www/uat.yourdomain.com"
REPO="https://github.com/yourusername/your-repo.git"
BRANCH="uat"

# Set environment variables
export FLASK_ENV=staging

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
# ssh $USER@$SERVER "sudo systemctl restart your-app-uat.service"

echo "Deployment to UAT environment completed!"
