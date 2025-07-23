from flask import Flask, render_template
import os

app = Flask(__name__)

@app.route('/')
def home():
    env = os.getenv('FLASK_ENV', 'development')
    return f"""
    <!DOCTYPE html>
    <html>
    <head>
        <title>CI/CD Demo App</title>
        <style>
            body {{
                font-family: Arial, sans-serif;
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
                text-align: center;
            }}
            .env-{env.lower()} {{
                color: {'green' if env == 'production' else 'blue' if env == 'staging' else 'orange'};
                font-weight: bold;
                font-size: 24px;
                margin: 20px 0;
            }}
        </style>
    </head>
    <body>
        <h1>Welcome to CI/CD Demo Application</h1>
        <div class="env-{env.lower()}">
            Environment: {env.upper()}
        </div>
        <p>This is a simple Flask application demonstrating CI/CD pipeline.</p>
        <p>Deployed using automated scripts without Docker or cloud services.</p>
        <p>Version: 1.0.0</p>
    </body>
    </html>
    """

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
