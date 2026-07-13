# Node.js + MongoDB Application Deployment on Azure using Jenkins CI/CD and Terraform

## Project Overview

This project demonstrates deploying a **Node.js + MongoDB web application** to **Microsoft Azure App Service** using a complete DevOps workflow.

The project implements:

* Infrastructure provisioning using **Terraform**
* Continuous Integration (CI) using **Jenkins**
* Continuous Deployment (CD) using **Jenkins**
* Azure authentication using **Service Principal**
* Automated application packaging
* Deployment to Azure App Service
* Post-deployment health verification


# Project Architecture

```
                  Developer
                     |
                     v
              GitHub Repository
                     |
        +------------+-------------+
        |                          |
        v                          v
   Terraform                  Jenkins CI/CD
   (IaC)                           |
        |                          |
        v                          v
 Azure Infrastructure        Build Pipeline
        |                    - Checkout
        |                    - npm install
        v                    - Test
 Azure App Service           - Package ZIP
        |                          |
        |                          v
        |                  Deployment Artifact
        |                          |
        +------------+-------------+
                     |
                     v
            Azure Service Principal
                     |
                     v
          Jenkins CD Deployment
                     |
                     v
        Azure App Service Running
                     |
          +----------+----------+
          |                     |
          v                     v
    Node.js App            MongoDB
          |
          v
     Health Check
          |
          v
     Live Website

```

---

# Architecture Explanation

## GitHub Repository

The application source code and Jenkins pipeline configuration are stored in GitHub.

Repository:

```
https://github.com/sushrithanyam/azure-nodejs-devops-project.git
```

Jenkins automatically pulls the latest code from GitHub during pipeline execution.

---

# Terraform Infrastructure Provisioning

Terraform is used for Infrastructure as Code (IaC).

Terraform provisions Azure resources before application deployment.

Resources created:

* Azure Resource Group
* Azure App Service
* Required Azure configurations

Terraform folder:

```
terraform/

├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars

```

Terraform commands:

```
terraform init

terraform plan

terraform apply
```

---

# Jenkins CI Pipeline

The Jenkins CI pipeline automates the application build process.

## Pipeline Stages

### 1. Checkout Source Code

Jenkins downloads the application from GitHub.

Example:

```
git checkout main branch
```

---

### 2. Install Dependencies

Node.js dependencies are installed using:

```
npm install
```

This downloads all required packages from `package.json`.

---

### 3. Application Testing

Jenkins executes:

```
npm test
```

The project currently does not contain a test script, so the pipeline continues without failing.

---

### 4. Package Application

Jenkins creates a deployment artifact:

```
app-clean.zip
```

The package contains the application source code required for Azure deployment.

Excluded:

```
node_modules
.git
```

---

# Jenkins CD Pipeline

The Continuous Deployment stage deploys the application to Azure.

## Azure Authentication

Jenkins authenticates with Azure using a Service Principal.

Authentication details:

* Client ID
* Client Secret
* Tenant ID

Command used:

```
az login --service-principal
```

---

## Deploy Application to Azure App Service

Deployment command:

```
az webapp deploy \
--resource-group rg-nodejs-mongodb-devops \
--name node-task-app-sushr12345 \
--src-path app-clean.zip \
--type zip
```

Azure App Service:

```
Application Name:
node-task-app-sushr12345


Resource Group:
rg-nodejs-mongodb-devops
```

---

# Health Check

After deployment Jenkins verifies that the application is running.

Health check command:

```
curl -I https://node-task-app-sushr12345.azurewebsites.net
```

Successful response:

```
HTTP 200 OK
```

---

# Technologies Used

| Technology        | Purpose                     |
| ----------------- | --------------------------- |
| Node.js           | Application runtime         |
| Express.js        | Backend framework           |
| MongoDB           | Database                    |
| Azure App Service | Cloud hosting               |
| Terraform         | Infrastructure provisioning |
| Jenkins           | CI/CD automation            |
| GitHub            | Source control              |
| Azure CLI         | Deployment automation       |

---

# Project Structure

```
azure-nodejs-devops-project

│
├── app.js
├── package.json
├── routes/
├── views/
├── public/
│
├── terraform/
│   │
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── Jenkinsfile
│
└── README.md

```

---

# Screenshots Description

## Screenshot 1: Jenkins Pipeline Started

**Description:**

Shows Jenkins successfully connecting to GitHub and loading the Jenkinsfile.

Screenshot should include:

* Build started
* Git checkout successful
* Pipeline stages visible

---

## Screenshot 2: Installing Dependencies

**Description:**

Shows Jenkins executing:

```
npm install
```

and installing Node.js packages successfully.

---

## Screenshot 3: Creating Deployment Artifact

**Description:**

Shows Jenkins packaging the application:

```
app-clean.zip
```

This ZIP file is used for Azure deployment.

---

## Screenshot 4: Terraform Infrastructure Deployment

**Description:**

Shows Terraform creating Azure resources.

Commands:

```
terraform init

terraform plan

terraform apply
```

Expected resources:

* Resource Group
* Azure App Service

---

## Screenshot 5: Azure Portal Resources

**Description:**

Azure Portal screenshot showing:

Resource Group:

```
rg-nodejs-mongodb-devops
```

App Service:

```
node-task-app-sushr12345
```

---

## Screenshot 6: Jenkins Azure Deployment

**Description:**

Shows Jenkins successfully authenticating with Azure and deploying:

```
app-clean.zip
```

to Azure App Service.

---

## Screenshot 7: Application Running

**Description:**

Browser screenshot showing the live application.

URL:

```
https://node-task-app-sushr12345.azurewebsites.net
```

---

# Complete CI/CD Flow

```
Developer
    |
    v

GitHub Repository

    |
    v

Jenkins Pipeline

    |
    |
    +----------------+
    |                |
    v                v

CI Pipeline        CD Pipeline

npm install        Azure Login

npm test           Deploy ZIP

Package ZIP        Health Check


    |
    v

Azure App Service

    |
    v

Live Node.js Application

```

---

# Conclusion

This project demonstrates an end-to-end DevOps implementation by combining:

* Terraform for automated infrastructure provisioning
* Jenkins for CI/CD automation
* GitHub for source control
* Azure App Service for hosting
* Service Principal authentication for secure deployment

The final result is a fully automated pipeline that builds, packages, deploys, and validates a Node.js + MongoDB application on Azure.
 