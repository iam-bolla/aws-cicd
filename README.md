# 🚀 AWS CI/CD with CodePipeline & CodeBuild

This repository demonstrates **Continuous Integration (CI)** using **AWS CodePipeline** and **AWS CodeBuild**.  
We’ll build, test, and push a Docker image securely using AWS services, while managing secrets with **AWS Systems Manager Parameter Store**.

---

## 📌 Prerequisites
- AWS Account with required permissions  
- [Fork this repository](https://github.com/iam-bolla/aws-cicd)  
- Basic knowledge of Git, Docker, and AWS services  

---

## ⚙️ Setup Guide

### 1. Create a CodeBuild Project
1. Go to **AWS Console → CodeBuild → Create project**  
2. Connect your **GitHub account**  
3. Paste the `buildspec.yaml` from this repo  
4. Choose *New service role* → AWS will create a default IAM role  
5. Click **Create Project**

---

### 2. Secure Secrets with Parameter Store
Avoid hardcoding credentials in `buildspec.yaml`.  
Instead, store them as **SecureString parameters** in AWS Systems Manager Parameter Store:

- `/myapp/docker-credentials/username`  
- `/myapp/docker-credentials/password`  
- `/myapp/docker-registry/url`

> ⚠️ Names must match the environment variables used in `buildspec.yaml`.

---

### 3. IAM Role Permissions
Attach the following policy to the **CodeBuild service role**:
- **AmazonSSMFullAccess** (for practice; use least-privilege in production)

---

### 4. Create CodePipeline
1. Go to **AWS Console → CodePipeline → Create pipeline**  
2. Add:
   - **Source stage** → GitHub repo  
   - **Build stage** → Your CodeBuild project  
3. Save and create

---

## 📊 Workflow
1. Developer pushes code → GitHub  
2. **CodePipeline** triggers automatically  
3. **CodeBuild** executes build phases:  
   - Build  
   - Test  
   - Image Creation  
   - Scan  
   - Push to Docker Registry  
4. Secrets are fetched securely from **Parameter Store**

---

## ✅ Output
- Automated CI process in AWS  
- Docker image pushed to the registry  
- Secure secret handling via Parameter Store  

---

<img width="1015" height="591" alt="Screenshot 2025-08-30 203326" src="https://github.com/user-attachments/assets/dac5133f-d11b-42a7-b54c-c662bee35240" />

<img width="1287" height="323" alt="Screenshot 2025-08-30 203418" src="https://github.com/user-attachments/assets/c5ce4e53-62c3-4478-92c1-b3692f60b751" />



## 🔮 Next Steps
In the next part of this series, we’ll extend this setup with **AWS CodeDeploy** for **Continuous Deployment (CD)**. Stay tuned! 🎉  

---

## 📜 License
This project is licensed under the MIT License.
