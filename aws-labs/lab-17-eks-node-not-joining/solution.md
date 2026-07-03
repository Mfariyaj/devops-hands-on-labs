## Solution: lab-17-eks-node-not-joining

### Root Cause
EKS nodes NotReady: aws-auth ConfigMap missing role ARN, wrong AMI

### Category: EKS & Containers

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
EKS nodes NotReady: aws-auth ConfigMap missing role ARN, wrong AMI — this is a common production issue. Document the fix in your runbook.
