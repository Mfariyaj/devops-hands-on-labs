## Solution: lab-50-migration-dns-cutover

### Root Cause
Route53 weighted routing not shifting traffic: TTL too high, health check

### Category: Migration & Microservices

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
Route53 weighted routing not shifting traffic: TTL too high, health check — this is a common production issue. Document the fix in your runbook.
