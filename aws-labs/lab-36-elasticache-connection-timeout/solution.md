## Solution: lab-36-elasticache-connection-timeout

### Root Cause
ElastiCache Redis unreachable: not in VPC, SG blocking 6379

### Category: Storage & Database

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
ElastiCache Redis unreachable: not in VPC, SG blocking 6379 — this is a common production issue. Document the fix in your runbook.
