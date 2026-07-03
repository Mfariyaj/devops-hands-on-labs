## Solution: lab-54-three-tier-app-broken

### Root Cause
Classic 3-tier (ALB→EC2→RDS): each layer has connectivity issue

### Category: Migration & Microservices

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
Classic 3-tier (ALB→EC2→RDS): each layer has connectivity issue — this is a common production issue. Document the fix in your runbook.
