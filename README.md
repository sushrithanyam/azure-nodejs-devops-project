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
<img width="1122" height="1402" alt="Image Jul 12, 2026, 08_46_15 PM" src="https://github.com/user-attachments/assets/f9803a72-a45d-422c-a43e-4d0e25345c5c" />

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
<img width="1920" height="963" alt="image" src="https://github.com/user-attachments/assets/b7891e8e-dd3e-4d00-a7fe-9c2bf710de7b" />
<img width="1920" height="959" alt="image" src="https://github.com/user-attachments/assets/0924d984-34ba-49a3-976c-f6fb4971f0c4" />

---

## Screenshot 2: Installing Dependencies

**Description:**

Shows Jenkins executing:

```
npm install
```

and installing Node.js packages successfully.
<img width="1920" height="962" alt="image" src="https://github.com/user-attachments/assets/bd5a441c-7ae1-4220-acd4-37f41496fc4f" />

---

## Screenshot 3: Creating Deployment Artifact

**Description:**

Shows Jenkins packaging the application:

```
app-clean.zip
```

This ZIP file is used for Azure deployment.
<img width="1920" height="965" alt="image" src="https://github.com/user-attachments/assets/18a12c3c-1a46-4bcf-9c11-2d78a9e0b25b" />

---

## Screenshot 4: Terraform Infrastructure Deployment

**Description:**

Shows Terraform creating Azure resources.

Commands:

```
terraform init
<img width="1650" height="551" alt="image" src="https://github.com/user-attachments/assets/dca71246-9ed9-41df-8a70-42e5d9de243d" />

terraform plan
<img width="1639" height="736" alt="image" src="https://github.com/user-attachments/assets/6d5302c0-6756-4be5-a19e-00d54714b533" />

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
<img width="1920" height="962" alt="image" src="https://github.com/user-attachments/assets/126bd501-400c-4606-b6ee-a305aefe2551" />

---

## Screenshot 6: Jenkins Azure Deployment

**Description:**

Shows Jenkins successfully authenticating with Azure and deploying:

```
app-clean.zip
```

to Azure App Service.
<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/e4b5b14e-7b32-49ef-8462-505ed9ba7ba1" />
<img width="1920" height="968" alt="image" src="https://github.com/user-attachments/assets/e6859578-67cc-4406-8e48-9869b4465d8d" />
<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/cc03dc22-875a-4863-9b95-a5f4c9710b1e" />

---

## Screenshot 7: Application Running

**Description:**

Browser screenshot showing the live application.

URL:

```
https://node-task-app-sushr12345.azurewebsites.net
```
<img width="1920" height="962" alt="image" src="https://github.com/user-attachments/assets/ea9ee670-ad25-4272-852c-320447bef7fa" />
<img width="1920" height="962" alt="image" src="https://github.com/user-attachments/assets/61a3329b-7ca5-46ca-b577-227268da085d" />
<img width="1920" height="962" alt="image" src="https://github.com/user-attachments/assets/dce45e0a-50b0-4840-bf36-4dc12fff19ca" />

---
## Screenshot 8: Health Check

**Description:**

Showing health check.

<img width="1920" height="968" alt="image" src="https://github.com/user-attachments/assets/98418cfc-2f95-41df-b99a-c96a7f9862e3" />

---
## Screenshot 9: Monitor Metrics and Application Insights

**Description:**
The application is monitored using Azure Monitor and Application Insights.

<img width="1920" height="959" alt="image" src="https://github.com/user-attachments/assets/52cb6b5d-efc4-462d-ac95-c27bb1d9eee0" />
<img width="1920" height="957" alt="image" src="https://github.com/user-attachments/assets/1f07d1d9-0cdb-450c-b93d-6bbec8000b65" />
<img width="1920" height="951" alt="image" src="https://github.com/user-attachments/assets/b106051e-2d56-4657-8436-8b670bdf391e" />

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
 
