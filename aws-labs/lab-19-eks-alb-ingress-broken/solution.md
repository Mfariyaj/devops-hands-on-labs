## Solution: lab-19-eks-alb-ingress-broken

### Root Cause
AWS ALB Ingress Controller not creating ALB: subnet tags missing

### Category: EKS & Containers

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
AWS ALB Ingress Controller not creating ALB: subnet tags missing — this is a common production issue. Document the fix in your runbook.
