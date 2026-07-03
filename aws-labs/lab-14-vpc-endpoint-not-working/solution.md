## Solution: lab-14-vpc-endpoint-not-working

### Root Cause
S3 VPC endpoint created but still going through NAT: route table not associated

### Category: Networking & VPC

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
S3 VPC endpoint created but still going through NAT: route table not associated — this is a common production issue. Document the fix in your runbook.
