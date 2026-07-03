## Solution: lab-09-vpc-no-internet-nat

### Root Cause
Private subnet EC2 can't reach internet: NAT Gateway missing/misconfigured

### Category: Networking & VPC

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
Private subnet EC2 can't reach internet: NAT Gateway missing/misconfigured — this is a common production issue. Document the fix in your runbook.
