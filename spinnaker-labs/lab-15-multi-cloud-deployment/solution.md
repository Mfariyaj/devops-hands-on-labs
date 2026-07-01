# Lab 15: Solution — Multi-Cloud Deployment

## Root Cause

1. **Account name mismatch**: Pipeline uses `aws-production` but Clouddriver has `aws-prod`
2. **Placeholder account ID in AssumeRole ARN**: `000000000000` should be `222222222222` (the managed account)
3. **Timeout too short**: 60 seconds is insufficient for cross-account ASG creation (typically takes 120-180s)

## Step-by-Step Fix

### Fix 1: Correct account name in pipeline.json

```json
{
  "account": "aws-prod"
}
```

### Fix 2: Fix AssumeRole ARN in clouddriver-local.yml

```yaml
aws:
  accounts:
    - name: aws-prod
      accountId: "111111111111"
      assumeRole: "arn:aws:iam::222222222222:role/SpinnakerManaged"
```

### Fix 3: Increase timeout in pipeline.json

```json
{
  "stageTimeoutMs": 300000
}
```
(300000ms = 5 minutes)

### Apply fixes
```bash
# Update Clouddriver config and restart
hal config provider aws account edit aws-prod \
  --assume-role "arn:aws:iam::222222222222:role/SpinnakerManaged"
hal deploy apply

# Or with operator:
kubectl apply -f clouddriver-local.yml
kubectl rollout restart deployment spin-clouddriver -n spinnaker

# Save pipeline
spin pipeline save --file pipeline.json
```

## Verification

```bash
# Verify account exists
curl http://localhost:8084/credentials | jq '.[] | select(.name == "aws-prod")'

# Test AssumeRole
aws sts assume-role \
  --role-arn arn:aws:iam::222222222222:role/SpinnakerManaged \
  --role-session-name spinnaker-test

# Execute pipeline (K8s part)
spin pipeline execute --name "Multi-Cloud Deploy" --application myapp

# After manual judgment, check AWS deployment
aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names myapp-prod-v001 \
  --region us-east-1
```

## Key Takeaways

- Account names in pipelines must EXACTLY match Clouddriver's configured account names
- AssumeRole ARN must point to the TARGET (managed) account, not the source
- Cross-account deployments take longer — increase timeouts to 5+ minutes
- Always use `aws sts assume-role` to test IAM configuration before Spinnaker
- The `accountId` in Clouddriver config is the MANAGING account; `assumeRole` points to MANAGED account
- Trust policies must be configured on BOTH sides: managing account's permission to call AssumeRole AND managed account's trust policy allowing it
