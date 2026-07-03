## Solution: lab-29-api-gateway-authorizer-denied

### Root Cause
Custom authorizer denying valid tokens: wrong token source, cache stale

### Category: Serverless

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
Custom authorizer denying valid tokens: wrong token source, cache stale — this is a common production issue. Document the fix in your runbook.
