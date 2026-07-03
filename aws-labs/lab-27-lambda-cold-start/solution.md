## Solution: lab-27-lambda-cold-start

### Root Cause
Lambda cold start >10s: large deployment package, VPC ENI attach

### Category: Serverless

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
Lambda cold start >10s: large deployment package, VPC ENI attach — this is a common production issue. Document the fix in your runbook.
