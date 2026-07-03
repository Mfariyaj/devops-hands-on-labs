## Solution: lab-31-s3-bucket-policy-conflict

### Root Cause
S3 403 Forbidden: bucket policy + IAM + Block Public Access conflicting

### Category: Storage & Database

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
S3 403 Forbidden: bucket policy + IAM + Block Public Access conflicting — this is a common production issue. Document the fix in your runbook.
