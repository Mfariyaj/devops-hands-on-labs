## Solution: lab-20-eks-cluster-autoscaler

### Root Cause
Cluster Autoscaler not scaling: ASG tags wrong, IAM permission missing

### Category: EKS & Containers

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
Cluster Autoscaler not scaling: ASG tags wrong, IAM permission missing — this is a common production issue. Document the fix in your runbook.
