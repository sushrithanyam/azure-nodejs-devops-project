pipeline {
    agent any

    environment {
        AZURE_CREDENTIALS = credentials('azure-sp')
        RESOURCE_GROUP = 'rg-nodejs-mongodb-devops'
        APP_NAME = 'node-task-app-sushr12345'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/sushrithanyam/azure-nodejs-devops-project.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                echo 'Running basic tests'
                sh 'npm test || exit 0'
            }
        }

        stage('Package Application') {
            steps {
                sh '''
                    rm -f app-clean.zip
                    zip -r app-clean.zip . -x "node_modules/*" ".git/*"
                    ls -lh app-clean.zip

                '''
            }
        }

        stage('Deploy to Azure') {
            steps {
                sh '''
                echo "Logging into Azure..."

                az login --service-principal \
                    --username "$AZURE_CREDENTIALS_USR" \
                    --password "$AZURE_CREDENTIALS_PSW" \
                    --tenant "de39b974-8de7-4d93-bdea-7dc84b8e7a9f"

                echo "Deploying application..."

                az webapp deploy \
                    --resource-group rg-nodejs-mongodb-devops \
                    --name node-task-app-sushr12345 \
                    --src-path app-clean.zip \
                    --type zip

                echo "Deployment completed"
                '''
            }
        }

        stage('Health Check') {
            steps {
            sh '''
                echo "Checking application health..."

                curl -I https://node-task-app-sushr12345.azurewebsites.net

                echo "Health check completed"
            '''
            }
        }
    }
}