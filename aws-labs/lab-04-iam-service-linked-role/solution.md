## Solution: lab-04-iam-service-linked-role

### Root Cause
Service-linked role can't be modified, service needs specific SLR

### Category: IAM & Security

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
Service-linked role can't be modified, service needs specific SLR — this is a common production issue. Document the fix in your runbook.
