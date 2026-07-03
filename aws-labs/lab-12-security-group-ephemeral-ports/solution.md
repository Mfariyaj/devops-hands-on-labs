## Solution: lab-12-security-group-ephemeral-ports

### Root Cause
App works on port 443 but response never comes back: ephemeral ports blocked

### Category: Networking & VPC

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
App works on port 443 but response never comes back: ephemeral ports blocked — this is a common production issue. Document the fix in your runbook.
