# Lab 09: Solution — RBAC Fiat Denied

## Root Cause

1. **LDAP groupSearchBase typo**: `ou=Gruops` should be `ou=Groups` — Fiat can't find any groups, so users have no roles
2. **Role name mismatch**: Application permissions reference `developers` but LDAP group is `dev-team`
3. **Service account missing EXECUTE role**: The `spinnaker-pipeline-svc` service account is only in `platform-admins`, which isn't in the app's EXECUTE permission list

## Step-by-Step Fix

### Fix 1: Correct LDAP groupSearchBase in fiat-local.yml
```yaml
groupSearchBase: ou=Groups,dc=example,dc=com
```

### Fix 2: Update application permissions to use correct role name
```json
{
  "permissions": {
    "READ": ["dev-team", "qa-team"],
    "WRITE": ["dev-team"],
    "EXECUTE": ["dev-team", "platform-admins"]
  }
}
```

### Fix 3: Add proper role to service account
```json
{
  "serviceAccounts": [
    {
      "name": "spinnaker-pipeline-svc",
      "memberOf": ["dev-team", "platform-admins"]
    }
  ]
}
```

### Apply fixes
```bash
# Restart Fiat to pick up config change
kubectl rollout restart deployment spin-fiat -n spinnaker

# Update application permissions via API
curl -X PUT http://localhost:8084/applications/myapp \
  -H "Content-Type: application/json" \
  -d @application-permissions.json

# Force sync
curl -X POST http://localhost:7003/roles/sync

# Wait for sync to complete (30-60 seconds)
sleep 60
```

## Verification

```bash
# Check user roles are resolved
curl http://localhost:7003/authorize/john.doe | jq '.roles'
# Should include "dev-team"

# Check application access
curl -u john.doe:password http://localhost:8084/applications/myapp
# Should return 200, not 403

# Test pipeline execution
spin pipeline execute --name "Deploy" --application myapp
# Should not get 403

# Check Fiat sync log
kubectl logs -n spinnaker spin-fiat-xxx | grep "Synced" | tail -5
```

## Key Takeaways

- LDAP search base paths must be exactly correct — typos mean zero groups returned
- Role names in application permissions MUST match the identity provider exactly (case-sensitive)
- Service accounts need roles that have EXECUTE permission on the application
- Fiat caches roles — force sync with `POST /roles/sync` after changes
- Use `GET /authorize/<user>` to debug what roles Fiat sees for a user
- `allowAccessToUnknownApplications: false` means ALL apps need explicit permissions
