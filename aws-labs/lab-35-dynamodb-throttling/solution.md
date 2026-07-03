## Solution: lab-35-dynamodb-throttling

### Root Cause
DynamoDB ProvisionedThroughputExceeded: hot partition, wrong capacity mode

### Category: Storage & Database

### Fix
1. Identify the misconfigured component from the error
2. Check the relevant AWS service configuration
3. Apply the fix (update policy/SG/route/config)
4. Verify the error is resolved

### Key Takeaway
DynamoDB ProvisionedThroughputExceeded: hot partition, wrong capacity mode — this is a common production issue. Document the fix in your runbook.
