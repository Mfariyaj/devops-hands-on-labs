## Solution: lab-22-eks-coredns-not-resolving

### Root Cause
CoreDNS pods CrashLoop after node scale: IP exhaustion in subnet

### Category: EKS & Containers

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
CoreDNS pods CrashLoop after node scale: IP exhaustion in subnet — this is a common production issue. Document the fix in your runbook.
