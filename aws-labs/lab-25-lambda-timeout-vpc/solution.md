## Solution: lab-25-lambda-timeout-vpc

### Root Cause
Lambda timeout: deployed in VPC without NAT, can't reach DynamoDB

### Category: Serverless

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
Lambda timeout: deployed in VPC without NAT, can't reach DynamoDB — this is a common production issue. Document the fix in your runbook.
