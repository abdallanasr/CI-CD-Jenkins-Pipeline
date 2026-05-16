# Jenkins Shared Library CI/CD Project

## Overview

This project demonstrates a complete CI/CD workflow using Jenkins Shared Libraries for multiple Spring Boot microservices.

The primary objective of this project is to eliminate duplicated Jenkins pipeline code by creating a reusable shared pipeline that can be consumed by multiple applications.

The same shared library is responsible for:

- Cloning repositories
- Building Maven projects
- Packaging Spring Boot applications
- Building Docker images
- Pushing images to Docker Hub
- Deploying containers automatically

The shared pipeline is currently used to deploy **3 different Spring Boot services**.

---

# Project Architecture Diagram

<img width="1536" height="1024" alt="Architecture Diagram" src="https://github.com/user-attachments/assets/2ca9f567-f9a7-459d-925e-855262abe313" />

---

# Architecture Overview

```text
                    +--------------------------+
                    |  Jenkins Shared Library  |
                    |     buildApp.groovy      |
                    +------------+-------------+
                                 |
        ---------------------------------------------------
        |                        |                        |
        v                        v                        v

   Spring Service A        Spring Service B        Spring Service C
    Jenkinsfile             Jenkinsfile             Jenkinsfile
````

Each service contains only a lightweight `Jenkinsfile` that calls the reusable shared library.

---

# CI/CD Workflow

```text
GitHub Push
     ↓
GitHub Webhook
     ↓
Jenkins Pipeline
     ↓
Maven Build
     ↓
Docker Build
     ↓
DockerHub Push
     ↓
Container Deployment
```

---

# GitHub Repositories

## Jenkins Shared Library

* [https://github.com/abdallanasr/shared-lib](https://github.com/abdallanasr/shared-lib)

## Spring Boot Service A

* [https://github.com/abdallanasr/spring-petclinic-A](https://github.com/abdallanasr/spring-petclinic-A)

## Spring Boot Service B

* [https://github.com/abdallanasr/spring-petclinic-B](https://github.com/abdallanasr/spring-petclinic-B)

## Spring Boot Service C

* [https://github.com/abdallanasr/spring-petclinic-C](https://github.com/abdallanasr/spring-petclinic-C)

---

# Technologies Used

| Technology             | Purpose                     |
| ---------------------- | --------------------------- |
| Java 17                | Backend Development         |
| Spring Boot            | Application Framework       |
| Maven                  | Build Tool                  |
| Docker                 | Containerization            |
| Jenkins                | CI/CD Automation            |
| Jenkins Shared Library | Reusable Pipelines          |
| Docker Hub             | Container Registry          |
| AWS EC2                | Cloud Infrastructure        |
| Terraform              | Infrastructure Provisioning |

---

# Shared Library Structure

```text
shared-lib/
│
├── vars/
│   └── buildApp.groovy
│
└── README.md
```

---

# Shared Pipeline Responsibilities

The shared library automates the following tasks:

* Clone application source code
* Build Maven projects
* Package Spring Boot applications
* Build Docker images
* Tag Docker images
* Push images to Docker Hub
* Deploy Docker containers automatically

---

# Example Jenkinsfile

Each application repository contains a minimal Jenkinsfile:

```groovy
@Library('shared-lib-test@main') _

buildApp(
    PORT: '8081',
    IMAGE_NAME: 'service-a',
    IMAGE_TAG: 'latest',
    REPO_NAME: 'abdallanasr/service-a',
    CONTAINER_NAME: 'service-a-container',
    REPO_URL: 'https://github.com/abdallanasr/spring-petclinic-A.git'
)
```

---

# Docker Workflow

```text
docker build
docker tag
docker push
docker run
```

---

# Infrastructure Provisioning

Terraform provisions the complete infrastructure automatically:

* Jenkins Master EC2 Instance
* Jenkins Agent EC2 Instance
* Security Groups
* Elastic IP Addresses
* 100GB EBS Volumes

---

# Jenkins Configuration

## Required Tools

### Maven Configuration

```text
Manage Jenkins → Tools → Maven Installations
```

### JDK Configuration

```text
Manage Jenkins → Tools → JDK Installations
```

---

# Required Credentials

## Docker Hub Credentials

Docker Hub credentials are configured inside Jenkins:

```text
Manage Jenkins → Credentials
```

### Credential Type

```text
Username with password
```

### Credentials ID

```text
docker-cred
```

---

# Jenkins Agent Configuration

The Jenkins agent communicates with the Jenkins master using SSH authentication.

### Example Remote Root Directory

```text
/home/jenkins
```

---

# Pipeline Stages

```text
Clone
Build
Build Image
Push Image
Deploy
```

---

# Deployment Features

* Automatic Docker image creation
* Automatic DockerHub push
* Automatic container replacement
* Zero manual deployment steps
* Reusable shared CI/CD pipeline
* Multi-service support

---

# Key Learnings

* Building reusable Jenkins Shared Libraries
* Automating CI/CD pipelines
* Dockerizing Spring Boot applications
* Managing Jenkins credentials securely
* Configuring GitHub webhooks
* Deploying containers automatically on AWS EC2
* Infrastructure provisioning using Terraform
* Jenkins master-agent architecture

---

