## Solution: lab-08-kms-key-policy-denied

### Root Cause
KMS key policy not granting encrypt/decrypt to the right principal

### Category: IAM & Security

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
KMS key policy not granting encrypt/decrypt to the right principal — this is a common production issue. Document the fix in your runbook.
