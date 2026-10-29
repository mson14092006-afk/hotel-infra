# Application Load Balancer (ALB)

## 1. Overview

The **Application Load Balancer (ALB)** distributes incoming HTTP/HTTPS traffic to Flask application containers running on Amazon ECS Fargate.

## 2. Architecture
<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/5d017bfc-7c8d-45e4-8316-788c87c2f441" />



## 3. Design Decisions

- **Application Load Balancer:** Provides Layer 7 HTTP/HTTPS routing.
- **Public Subnets:** Allow the ALB to receive Internet traffic.
- **Private ECS Tasks:** Prevent application containers from being directly exposed to the Internet.
- **IP Target Type:** Required for ECS Fargate using `awsvpc` networking.

## 4. Module Inputs

| Variable | Description |
|---|---|
| `vpc_id` | VPC ID for the target group |
| `public_subnet_ids` | Public subnet IDs for the ALB |
| `security_group_id` | Security group ID attached to the ALB |
