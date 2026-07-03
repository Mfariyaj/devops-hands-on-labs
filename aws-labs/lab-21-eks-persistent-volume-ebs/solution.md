## Solution: lab-21-eks-persistent-volume-ebs

### Root Cause
EBS CSI driver PVC stuck Pending: StorageClass wrong, AZ mismatch

### Category: EKS & Containers

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
EBS CSI driver PVC stuck Pending: StorageClass wrong, AZ mismatch — this is a common production issue. Document the fix in your runbook.
