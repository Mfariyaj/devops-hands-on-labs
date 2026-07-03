# ☁️ AWS Troubleshooting Labs

## 55 Real-World AWS Broken Scenarios (8+ Year Experience Level)

---

## 📚 Overview

These labs cover the **real AWS production issues** that senior DevOps/Cloud engineers face daily. Organized by domain, progressing from common to complex.

---

## 🚀 How To Use

### Prerequisites:
- AWS CLI configured (`aws configure`)
- AWS account (some labs simulate locally, some need real AWS)
- Basic → Expert AWS knowledge

### Steps:
1. `cd lab-XX-name && ./deploy.sh`
2. Read the error/scenario
3. Diagnose using AWS CLI
4. Fix and verify

---

## 📋 Labs by Category

### 🔐 IAM & Security (Labs 01-08)
| # | Lab | Difficulty | Scenario |
|---|-----|-----------|----------|
| 01 | iam-permission-denied | ⭐⭐ | Missing permissions, wrong ARN, SCP blocking |
| 02 | iam-cross-account-assume-role | ⭐⭐⭐ | Trust policy wrong, external ID mismatch |
| 03 | iam-permission-boundary | ⭐⭐⭐ | Boundary blocking despite policy allowing |
| 04 | iam-service-linked-role | ⭐⭐⭐ | SLR can't be modified, service needs specific role |
| 05 | iam-session-policy-conflict | ⭐⭐⭐ | Session policy reducing role permissions |
| 06 | iam-condition-key-mismatch | ⭐⭐⭐ | SourceIp/RequestedRegion conditions wrong |
| 07 | secrets-manager-rotation-failed | ⭐⭐⭐ | Lambda rotation timeout, permissions |
| 08 | kms-key-policy-denied | ⭐⭐⭐ | KMS key policy not granting access |

### 🌐 Networking & VPC (Labs 09-16)
| # | Lab | Difficulty | Scenario |
|---|-----|-----------|----------|
| 09 | vpc-no-internet-nat | ⭐⭐ | Private subnet missing NAT Gateway |
| 10 | vpc-peering-routing | ⭐⭐⭐ | Peering connected but no routes |
| 11 | vpc-transit-gateway | ⭐⭐⭐⭐ | Transit Gateway cross-VPC failing |
| 12 | security-group-ephemeral-ports | ⭐⭐ | Return traffic blocked (ephemeral ports) |
| 13 | nacl-stateless-blocking | ⭐⭐ | NACL blocking return (stateless!) |
| 14 | vpc-endpoint-not-working | ⭐⭐⭐ | S3 endpoint not being used |
| 15 | dns-private-hosted-zone | ⭐⭐⭐ | Private zone not resolving |
| 16 | elb-target-unhealthy | ⭐⭐ | ALB health check failing |

### ☸️ EKS & Containers (Labs 17-24)
| # | Lab | Difficulty | Scenario |
|---|-----|-----------|----------|
| 17 | eks-node-not-joining | ⭐⭐⭐ | aws-auth ConfigMap wrong |
| 18 | eks-pod-identity-failed | ⭐⭐⭐ | IRSA/Pod Identity not working |
| 19 | eks-alb-ingress-broken | ⭐⭐⭐ | ALB not created (subnet tags) |
| 20 | eks-cluster-autoscaler | ⭐⭐⭐ | Not scaling (ASG tags wrong) |
| 21 | eks-persistent-volume-ebs | ⭐⭐⭐ | PVC stuck Pending (AZ mismatch) |
| 22 | eks-coredns-not-resolving | ⭐⭐⭐⭐ | IP exhaustion in subnet |
| 23 | ecr-push-pull-denied | ⭐⭐ | Token expired, repo policy wrong |
| 24 | ecs-task-not-starting | ⭐⭐⭐ | Task role missing, secret fetch fails |

### ⚡ Serverless (Labs 25-30)
| # | Lab | Difficulty | Scenario |
|---|-----|-----------|----------|
| 25 | lambda-timeout-vpc | ⭐⭐⭐ | Lambda in VPC can't reach internet |
| 26 | lambda-memory-oom | ⭐⭐ | OOM: 128MB not enough |
| 27 | lambda-cold-start | ⭐⭐⭐ | 10s cold start (VPC + large package) |
| 28 | api-gateway-cors | ⭐⭐ | CORS headers missing |
| 29 | api-gateway-authorizer-denied | ⭐⭐⭐ | Custom authorizer rejecting valid tokens |
| 30 | step-functions-state-failed | ⭐⭐⭐ | Payload too large, wrong input path |

### 💾 Storage & Database (Labs 31-38)
| # | Lab | Difficulty | Scenario |
|---|-----|-----------|----------|
| 31 | s3-bucket-policy-conflict | ⭐⭐ | Bucket policy + IAM + Block Public conflicting |
| 32 | s3-replication-not-working | ⭐⭐⭐ | CRR not replicating (versioning, IAM) |
| 33 | rds-connection-refused | ⭐⭐ | Wrong SG, not same VPC, SSL required |
| 34 | rds-failover-downtime | ⭐⭐⭐⭐ | App not reconnecting after failover |
| 35 | dynamodb-throttling | ⭐⭐⭐ | Hot partition, capacity mode wrong |
| 36 | elasticache-connection-timeout | ⭐⭐ | Redis unreachable (VPC, SG) |
| 37 | rds-storage-full | ⭐⭐⭐ | Storage autoscaling disabled, binlogs |
| 38 | aurora-global-replication-lag | ⭐⭐⭐⭐ | Replication lag >1s |

### 💰 Cost Optimization (Labs 39-44)
| # | Lab | Difficulty | Scenario |
|---|-----|-----------|----------|
| 39 | cost-unused-resources | ⭐⭐ | Unattached EBS, idle ELBs, old snapshots |
| 40 | cost-right-sizing | ⭐⭐⭐ | Over-provisioned EC2 (m5.4xl at 5% CPU) |
| 41 | cost-reserved-vs-savings | ⭐⭐⭐ | Wrong RI family, savings plan analysis |
| 42 | cost-s3-lifecycle | ⭐⭐ | TB of data in Standard (should be Glacier) |
| 43 | cost-nat-gateway-expensive | ⭐⭐⭐ | $500/month NAT (should use VPC endpoints) |
| 44 | cost-data-transfer | ⭐⭐⭐ | $2000/month cross-AZ (use AZ-aware routing) |

### 🏢 Multi-Account & Organization (Labs 45-48)
| # | Lab | Difficulty | Scenario |
|---|-----|-----------|----------|
| 45 | org-scp-blocking-dev | ⭐⭐⭐⭐ | SCP too broad, blocking developers |
| 46 | org-cross-account-access | ⭐⭐⭐⭐ | Role chain fails between accounts |
| 47 | org-cloudtrail-missing-events | ⭐⭐⭐ | Org trail not logging member accounts |
| 48 | org-service-quotas | ⭐⭐ | Service limits hit in new account |

### 🚀 Migration & Microservices (Labs 49-55)
| # | Lab | Difficulty | Scenario |
|---|-----|-----------|----------|
| 49 | migration-database-cutover | ⭐⭐⭐⭐ | DMS replication stuck, CDC not working |
| 50 | migration-dns-cutover | ⭐⭐⭐⭐ | Route53 weighted routing not shifting |
| 51 | microservice-service-discovery | ⭐⭐⭐ | Cloud Map namespace wrong |
| 52 | microservice-circuit-breaker | ⭐⭐⭐⭐ | App Mesh outlier detection wrong |
| 53 | microservice-tracing-gaps | ⭐⭐⭐ | X-Ray segments missing |
| 54 | three-tier-app-broken | ⭐⭐⭐⭐ | ALB→EC2→RDS: each layer broken |
| 55 | blue-green-deployment-failed | ⭐⭐⭐⭐ | CodeDeploy hooks failing, no rollback |

---

## 🛠️ Essential AWS Debugging Commands

```bash
# Identity & Permissions
aws sts get-caller-identity
aws iam simulate-principal-policy --policy-source-arn <arn> --action-names <action>
aws iam get-policy-version --policy-arn <arn> --version-id v1
aws organizations list-policies --filter SERVICE_CONTROL_POLICY

# Networking
aws ec2 describe-security-groups --group-ids sg-xxx
aws ec2 describe-route-tables --filters Name=vpc-id,Values=vpc-xxx
aws ec2 describe-nat-gateways --filter Name=vpc-id,Values=vpc-xxx
aws ec2 describe-vpc-endpoints --filters Name=vpc-id,Values=vpc-xxx
aws elbv2 describe-target-health --target-group-arn <arn>

# EKS
aws eks describe-cluster --name my-cluster
kubectl get cm aws-auth -n kube-system -o yaml
kubectl describe pod -n kube-system aws-load-balancer-controller-*

# Serverless
aws lambda get-function-configuration --function-name my-func
aws logs tail /aws/lambda/my-func --follow
aws apigateway get-rest-apis

# Cost
aws ce get-cost-and-usage --time-period Start=2024-01-01,End=2024-01-31 --granularity MONTHLY --metrics BlendedCost
aws ec2 describe-volumes --filters Name=status,Values=available  # Unattached volumes!
aws pricing get-products --service-code AmazonEC2 --region us-east-1

# Debugging
aws cloudtrail lookup-events --lookup-attributes AttributeKey=EventName,AttributeValue=AssumeRole
aws health describe-events --filter eventStatusCodes=open
```

---

## 📖 Reference
- IAM: https://docs.aws.amazon.com/IAM/latest/UserGuide/
- VPC: https://docs.aws.amazon.com/vpc/latest/userguide/
- EKS: https://docs.aws.amazon.com/eks/latest/userguide/
- Cost: https://docs.aws.amazon.com/cost-management/
- Well-Architected: https://docs.aws.amazon.com/wellarchitected/
