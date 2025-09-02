# AWS CI/CD Series 🚀

hey folks 👋 this is my lil journey as a fresher exploring devops & cloud. not chasing jobs rn but fueling my curiosity.  
this repo is like a series where i break down **complete CI/CD on AWS** step by step (super beginner vibes).  

## what’s inside? 🔎
- Part 1 → Continuous Integration with **CodePipeline + CodeBuild**  
- Part 2 → Deployment with **CodeDeploy**  

## why this? 🤔
coz i’m entry-level & wanted to learn hands-on. most blogs felt too pro-level, so i’m writing it in my style (simple, slangy, and curious).  

## how to follow 📖
1. clone this repo  
2. each folder = a blog/tutorial part  
3. try it on your aws free tier account  
4. break things → fix things → learn things  

## goals 🎯
- not a pro guide, but a **curious fresher’s notes**  
- step by step → no overwhelm  
- sharing what i learn in real time  

## connect 🤝
if you’re also new into devops/cloud → let’s vibe, share tips, maybe break aws free tier together 😂  

---
⭐ if you find this fun/useful, it means a lot ✨

# # 🚀 Part 1: AWS CI/CD with CodePipeline & CodeBuild

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

# 🚀 Part 2: Continuous Deployment with AWS CodeDeploy (Integrating with CodePipeline)

This README walks through the **Continuous Deployment (CD)** part of the AWS CI/CD pipeline using **CodeDeploy** and **CodePipeline**.  

In [Part 1](../part1/README.md), we covered **Continuous Integration (CI)** with CodePipeline + CodeBuild.  
Now, let’s extend it by adding **deployment to EC2**.

---

## ⚙️ Step 1: Create a CodeDeploy Application
1. Login to **AWS Console → CodeDeploy**.  
2. Click **Create Application**.  
3. Select **EC2/On-Premises** as the compute platform.  
4. Provide a name and create the application.  

---

## ⚡ Step 2: Launch an EC2 Instance (Deployment Target)
1. Launch an **EC2 instance**.  
2. Add a tag (for CodeDeploy to identify it):  
   - **Key:** `Name`  
   - **Value:** `simple-app`  

---

## 🔑 Step 3: Configure IAM Roles
We need **two IAM roles**:  

- **EC2 Role →** to talk to CodeDeploy  
  - Attach `AmazonEC2RoleforAWSCodeDeploy` (or `AmazonEC2FullAccess` for demo).  

- **CodeDeploy Role →** to deploy to EC2  
  - Attach `AWSCodeDeployRole` (or full access for demo).  

👉 Attach these roles via **IAM Console** or while creating resources.  

---

## 🖥️ Step 4: Install CodeDeploy Agent on EC2
Run these commands on your EC2 instance:  

```bash
sudo apt update -y
sudo apt install ruby-full wget -y
cd /home/ubuntu
wget https://aws-codedeploy-<region>.s3.<region>.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent status
```
(Replace <region> with your AWS region.)
✅ Make sure the agent is running.

---
Step 5: Create Deployment Group

Go to CodeDeploy → Your Application → Create Deployment Group.

Select the IAM Role created for CodeDeploy.

Choose the EC2 instance by selecting tags (Name = simple-app).

Disable the Load Balancer (not needed in this demo).

Create the group.

---
Step 6: Create Deployment

In your application, click Create Deployment.

Provide the GitHub commit ID you want to deploy.

Confirm and create.

On your EC2 instance, install Docker:

sudo apt install docker.io -y


Deployment will now run, and you’ll see it progress in the CodeDeploy Console.

<img width="1411" height="769" alt="Screenshot 2025-09-02 144040" src="https://github.com/user-attachments/assets/21194d69-f2f6-4498-9ac1-58227670c6c1" />


---
Step 7: Integrate CodeDeploy with CodePipeline

Go to CodePipeline → Your Pipeline → Edit.

Click Add Stage → name it Deploy.

Add Action Group → choose CodeDeploy as the action provider.

Link it to the application & deployment group you created earlier.

Save.

✅ From now on, every commit → triggers CodePipeline → runs CodeBuild (CI) → then CodeDeploy (CD).

---

Output

Application is deployed to EC2 whenever a commit is pushed.

Full end-to-end CI/CD pipeline is ready:

GitHub → CodePipeline → CodeBuild → CodeDeploy → EC2.

<img width="1814" height="814" alt="Screenshot 2025-09-02 165322" src="https://github.com/user-attachments/assets/66a3cdbd-9ef6-46d6-8e18-a233049d0292" />
