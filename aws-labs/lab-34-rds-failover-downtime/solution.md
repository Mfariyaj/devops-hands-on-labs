## Solution: lab-34-rds-failover-downtime

### Root Cause
RDS Multi-AZ failover taking too long: app not reconnecting, DNS cache

### Category: Storage & Database

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
RDS Multi-AZ failover taking too long: app not reconnecting, DNS cache — this is a common production issue. Document the fix in your runbook.
