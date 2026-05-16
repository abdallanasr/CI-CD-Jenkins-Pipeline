# Jenkins Shared Library CI/CD Project

## Overview

This project demonstrates a complete CI/CD workflow using �entity["software","Jenkins","CI/CD automation server"] Shared Libraries for multiple Spring Boot services.

The main goal of this project is to avoid duplicating Jenkins pipeline code across services by creating a reusable shared pipeline.

The same shared library is used to build, package, dockerize, push, and deploy **3 different Spring Boot services**.

---

# Architecture

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
```

Each service contains only a lightweight `Jenkinsfile` that calls the shared library.

---
# GitHub Repositories

## Shared Library Repository
- [https://github.com/abdallanasr/shared-lib](https://github.com/abdallanasr/shared-lib-test)

## Spring Boot Service A
- [https://github.com/abdallanasr/spring-petclinic-A](https://github.com/abdallanasr/spring-petclinic-A)

## Spring Boot Service B
- [https://github.com/abdallanasr/spring-petclinic-B](https://github.com/abdallanasr/spring-petclinic-B)

## Spring Boot Service C
- [https://github.com/abdallanasr/spring-petclinic-C](https://github.com/abdallanasr/spring-petclinic-C)

---

# Technologies Used

* Java 17
* Spring Boot
* Maven
* Docker
* Jenkins Shared Library
* Docker Hub
* AWS EC2
* Terraform

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

The shared library handles:

 Cloning source code

 Building Maven projects

 Creating Docker images

 Tagging Docker images

 Pushing images to Docker Hub

 Deploying containers automatically

---

# Docker Workflow

```text
docker build
docker tag
docker push
docker run
```



# Infrastructure Provisioning

Terraform provisions:

* Jenkins Master EC2
* Jenkins Agent EC2
* Security Groups
* Elastic IPs
* 100GB EBS Volumes

---

#  Jenkins Configuration

## Required Tools

### Maven

```text
Manage Jenkins → Tools → Maven Installations
```

### JDK

```text
Manage Jenkins → Tools → JDK Installations
```

---

# Required Credentials

## Docker Hub Credentials

Add Docker Hub credentials:

```text
Manage Jenkins → Credentials
```

Type:

```text
Username with password
```

Credentials ID:

```text
docker-cred
```

---

# Jenkins Agent Configuration

The Jenkins agent connects using SSH.

Example remote root directory:

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
