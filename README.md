# Local CI/CD Pipeline for Python Web Application

This repository demonstrates a simple CI/CD pipeline for a Python web application that can be deployed to local servers without using Docker or external cloud services.

## Project Structure

```
.
├── app.py                # Main Flask application
├── requirements.txt      # Python dependencies
├── test_app.py          # Unit tests
└── scripts/
    ├── deploy-dev.sh    # Deployment script for Development
    ├── deploy-qa.sh     # Deployment script for QA
    ├── deploy-uat.sh    # Deployment script for UAT
    └── deploy-prod.sh   # Deployment script for Production
```

## Prerequisites

1. Python 3.6+
2. Git
3. SSH access to your deployment servers
4. (Optional) Virtual environment (venv)

## Local Development Setup

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-name>
   ```

2. Create and activate a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: .\venv\Scripts\activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Run the application locally:
   ```bash
   python app.py
   ```
   The application will be available at http://localhost:5000

## Running Tests

Run the unit tests with:
```bash
python -m unittest test_app.py
```

## Deployment

### Server Requirements
- Python 3.6+
- Git
- Web server (Nginx/Apache) - for production
- Systemd or similar process manager - for production

### Configuration

1. Update the deployment scripts in the `scripts/` directory with your server details:
   - Server IP/hostname
   - Deployment username
   - Application directory
   - Git repository URL
   - Branch name for each environment

2. Make the deployment scripts executable:
   ```bash
   chmod +x scripts/*.sh
   ```

### Deployment Process

1. **Development Environment**
   ```bash
   ./scripts/deploy-dev.sh
   ```

2. **QA Environment**
   ```bash
   ./scripts/deploy-qa.sh
   ```

3. **UAT Environment**
   ```bash
   ./scripts/deploy-uat.sh
   ```

4. **Production Environment**
   ```bash
   # Review the script first as it's commented out for safety
   ./scripts/deploy-prod.sh
   ```

## Environment Configuration

Each environment can be configured using environment variables. The application uses `FLASK_ENV` to determine the environment.

## Best Practices

1. **Branch Strategy**
   - `main` - Production code
   - `uat` - User Acceptance Testing
   - `qa` - Quality Assurance
   - `dev` - Development

2. **Security**
   - Use SSH keys for authentication
   - Restrict server access to authorized personnel
   - Keep sensitive information in environment variables, not in version control

## Troubleshooting

- **Permission Denied** when running scripts:
  ```bash
  chmod +x scripts/*.sh
  ```

- **Python package not found**:
  ```bash
  pip install -r requirements.txt
  ```

- **Application not starting**:
  - Check if the port is already in use
  - Verify all environment variables are set
  - Check application logs

## Next Steps

1. Set up a CI/CD server (like Jenkins) to automate the deployment process
2. Configure a webhook to trigger deployments on code push
3. Set up monitoring and logging
4. Configure a reverse proxy (Nginx/Apache) for production use
