## Solution: lab-06-iam-condition-key-mismatch

### Root Cause
Condition keys (aws:SourceIp, aws:RequestedRegion) blocking valid requests

### Category: IAM & Security

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
Condition keys (aws:SourceIp, aws:RequestedRegion) blocking valid requests — this is a common production issue. Document the fix in your runbook.
