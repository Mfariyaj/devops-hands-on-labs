## Solution: lab-53-microservice-tracing-gaps

### Root Cause
X-Ray traces incomplete: segments missing, SDK not propagating context

### Category: Migration & Microservices

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
X-Ray traces incomplete: segments missing, SDK not propagating context — this is a common production issue. Document the fix in your runbook.
