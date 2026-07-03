## Solution: lab-40-cost-right-sizing

### Root Cause
Over-provisioned EC2: m5.4xlarge running at 5% CPU, should be t3.medium

### Category: Cost Optimization

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
Over-provisioned EC2: m5.4xlarge running at 5% CPU, should be t3.medium — this is a common production issue. Document the fix in your runbook.
