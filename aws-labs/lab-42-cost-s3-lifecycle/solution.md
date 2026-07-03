## Solution: lab-42-cost-s3-lifecycle

### Root Cause
S3 costs too high: no lifecycle policy, TB of old data in Standard tier

### Category: Cost Optimization

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
S3 costs too high: no lifecycle policy, TB of old data in Standard tier — this is a common production issue. Document the fix in your runbook.
