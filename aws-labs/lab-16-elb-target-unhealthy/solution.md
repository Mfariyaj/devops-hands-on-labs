## Solution: lab-16-elb-target-unhealthy

### Root Cause
ALB targets all unhealthy: health check path wrong, SG blocking health check port

### Category: Networking & VPC

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
ALB targets all unhealthy: health check path wrong, SG blocking health check port — this is a common production issue. Document the fix in your runbook.
