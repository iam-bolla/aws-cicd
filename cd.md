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




