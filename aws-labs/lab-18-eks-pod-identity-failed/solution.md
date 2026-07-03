## Solution: lab-18-eks-pod-identity-failed

### Root Cause
EKS Pod Identity (IRSA) not working: wrong OIDC provider, annotation missing

### Category: EKS & Containers

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
EKS Pod Identity (IRSA) not working: wrong OIDC provider, annotation missing — this is a common production issue. Document the fix in your runbook.
