# 🏗 Architecture Diagram

```mermaid
graph TD

Internet((Internet))

IGW[Internet Gateway]

ALB[Application Load Balancer]

TG[Target Group]

EC21[EC2 Instance 1]

EC22[EC2 Instance 2]

Internet --> IGW
IGW --> ALB
ALB --> TG
TG --> EC21
TG --> EC22

```

# 🧱 Network Layout

| Component     | Location        |
| ------------- | --------------- |
| ALB           | Public Subnets  |
| EC2 Instances | Private Subnets |
| NAT Gateway   | Public Subnet   |

#📦 Infrastructure Components

| Resource         | Purpose                 |
| ---------------- | ----------------------- |
| VPC              | Network container       |
| Public Subnets   | ALB                     |
| Private Subnets  | EC2 instances           |
| Internet Gateway | Internet access         |
| NAT Gateway      | Private subnet internet |
| ALB              | Load balancing          |
| Target Group     | Register EC2            |
| EC2 Instances    | Web servers             |
| Security Groups  | Control traffic         |

# 🌐 Traffic Flow

```

User Browser
     │
     ▼
Application Load Balancer
     │
     ▼
Target Group
     │
 ┌─────────────┐
 ▼             ▼
EC2 #1       EC2 #2

```

# Project Structure

```
├── backend.tf
├── graph.png
├── main.tf
├── modules
│   ├── alb
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── ec2
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── user_data_express.sh
│   │   ├── user_data.sh
│   │   └── variables.tf
│   ├── sg
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variable.tf
│   └── vpc
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── outputs.tf
├── Project2Readme.md
├── Project3.md
├── provider.tf
├── README.md
└── variables.tf
```

# Web Server Setup

Each EC2 will install Nginx automatically using user_data.

```bash
#!/bin/bash
yum update -y
yum install nginx -y
systemctl start nginx
systemctl enable nginx

```
