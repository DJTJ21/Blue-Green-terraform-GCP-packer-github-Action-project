# 🌟 Blue-Green Deployment on GCP with Terraform, Packer, and GitHub Actions 🌟

Welcome to the **Blue-Green Deployment** project repository! This solution demonstrates a live feature change on a Java application deployed to customers using blue-green managed instance group deployments on Google Cloud Platform (GCP). The project automates the provisioning of infrastructure using Terraform, image building with Packer, and CI/CD pipelines with GitHub Actions.

---

## 📋 Overview

This project enables the seamless deployment of changes to a live stateful service without disrupting downstream customers. It includes the automated setup of various GCP services that are crucial for building a resilient application infrastructure.

### 🚀 Key Features
- **Blue-Green Deployment**: Switch between two identical environments for reliable updates.
- **Infrastructure as Code**: Automated deployment using Terraform, ensuring repeatability and scalability.
- **Image Building**: Docker image and VM image construction using Packer, integrated into the CI/CD pipeline.
- **CI/CD Integration**: Leverage GitHub Actions for continuous integration and deployment workflows.
- **GCP Services**: Utilizes a range of Google Cloud services including:
  - 🌐 Google Compute Engine
  - ⚙️ Cloud Load Balancing
  - 🌉 Service Networking
  - 🔐 Secret Manager
  - ☁️ Cloud Storage
  - 🚀 Cloud CDN
  - 🗄️ Cloud SQL
  - 🔑 IAM

## 🖼️ Architecture Diagram
![Architecture Diagram](assets/green.svg)

---

## ⚙️ Getting Started

### 📦 Prerequisites
Before you begin, ensure you have the following installed:
- **Terraform**: Infrastructure as Code tool to automate deployment.
- **GCP SDK**: Google Cloud SDK to interact with your GCP account.
- **Docker**: For building and managing container images.
- **Packer**: For creating machine images from source configurations.

### 🚀 Quickstart

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/Blue-Green-terraform-GCP-packer-github-Action-project.git
   cd Blue-Green-terraform-GCP-packer-github-Action-project
   ```

2. **Build Docker Image**:
   Navigate to the `cloudbuild-docker-image` directory and run:
   ```bash
   gcloud builds submit --config cloudbuild.yaml
   ```

3. **Build VM Image with Packer**:
   Navigate to the `cloudbuild-packer-image` directory and run:
   ```bash
   gcloud builds submit --config cloudbuild_packer_vm_img.yaml
   ```

4. **Deploy Infrastructure with Terraform**:
   - Before running Terraform, update the bucket name in the `backend.yml` file and ensure to specify the `source_image` output from the Packer build.
   - Then, execute the following commands:
   ```bash
   cd terraform-deployment
   terraform init
   terraform validate
   terraform plan -var "project_id=YOUR_PROJECT_ID" -var "source_image=YOUR_SOURCE_IMAGE"
   terraform apply -auto-approve -var "project_id=YOUR_PROJECT_ID" -var "source_image=YOUR_SOURCE_IMAGE"
   ```

---

## 📖 Detailed Guide
For a complete step-by-step guide, including screenshots and detailed explanations, please refer to the blog post. This post covers all the necessary steps to successfully implement this project.
