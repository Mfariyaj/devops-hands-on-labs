## Solution: lab-13-nacl-stateless-blocking

### Root Cause
NACL blocking return traffic: forgot NACLs are STATELESS unlike SGs

### Category: Networking & VPC

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
NACL blocking return traffic: forgot NACLs are STATELESS unlike SGs — this is a common production issue. Document the fix in your runbook.
