## Solution: lab-37-rds-storage-full

### Root Cause
RDS storage full: autoscaling disabled, binlogs not purged

### Category: Storage & Database

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
RDS storage full: autoscaling disabled, binlogs not purged — this is a common production issue. Document the fix in your runbook.
