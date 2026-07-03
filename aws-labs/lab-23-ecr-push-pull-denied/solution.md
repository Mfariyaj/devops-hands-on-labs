## Solution: lab-23-ecr-push-pull-denied

### Root Cause
ECR push/pull denied: login token expired, repo policy wrong, lifecycle deleting

### Category: EKS & Containers

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
ECR push/pull denied: login token expired, repo policy wrong, lifecycle deleting — this is a common production issue. Document the fix in your runbook.
