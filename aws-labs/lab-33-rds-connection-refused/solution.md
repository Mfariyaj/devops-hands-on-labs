## Solution: lab-33-rds-connection-refused

### Root Cause
Can't connect to RDS: wrong SG, not in same VPC, SSL required

### Category: Storage & Database

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
Can't connect to RDS: wrong SG, not in same VPC, SSL required — this is a common production issue. Document the fix in your runbook.
