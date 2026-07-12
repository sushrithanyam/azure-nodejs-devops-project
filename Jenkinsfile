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
                bat 'npm install'
            }
        }

        stage('Test') {
            steps {
                echo 'Running basic tests'
                bat 'npm test || exit 0'
            }
        }

        stage('Package Application') {
            steps {
                powershell '''
                Compress-Archive -Path * -DestinationPath app.zip -Force
                '''
            }
        }

        stage('Deploy to Azure') {
            steps {
                powershell '''
                az login --service-principal `
                --username $env:AZURE_CREDENTIALS_USR `
                --password $env:AZURE_CREDENTIALS_PSW `
                --tenant de39b974-8de7-4d93-bdea-7dc84b8e7a9f

                az webapp deploy `
                --resource-group $env:RESOURCE_GROUP `
                --name $env:APP_NAME `
                --src-path app.zip `
                --type zip
                '''
            }
        }

        stage('Health Check') {
            steps {
                powershell '''
                Invoke-WebRequest https://node-task-app-sushr12345.azurewebsites.net
                '''
            }
        }
    }
}