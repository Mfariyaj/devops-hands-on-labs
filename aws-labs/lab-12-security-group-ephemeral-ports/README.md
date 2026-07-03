## 🎯 How to Use This Lab

1. Deploy: `./deploy.sh`
2. Read the AWS error output
3. Identify which AWS service/config is wrong
4. Fix using AWS CLI or Console
5. Check `solution.md` if stuck

---

# lab-12-security-group-ephemeral-ports

## Category: Networking & VPC
## Difficulty: ⭐⭐⭐ Hard

## 📚 What This Teaches
App works on port 443 but response never comes back: ephemeral ports blocked

## 🔧 Scenario
App works on port 443 but response never comes back: ephemeral ports blocked

This is a real production scenario that AWS engineers encounter. Understanding this helps you debug faster in incident response.

## 💥 Expected Error
```
App works on port 443 but response never comes back: ephemeral ports blocked
```

## 💡 Hints

<details><summary>Hint 1</summary>
Read the error message. Which AWS service is returning the error? What specific action is being denied or failing?
</details>

<details><summary>Hint 2</summary>
Check the configuration: IAM policies, Security Groups, Route Tables, or service-specific settings.
</details>

<details><summary>Hint 3</summary>
Look at solution.md for the exact fix. Usually it's a missing permission, wrong ARN, or misconfigured networking.
</details>

## 🛠️ Useful Commands
```bash
aws sts get-caller-identity
aws iam simulate-principal-policy --policy-source-arn <arn> --action-names <action>
aws cloudtrail lookup-events --lookup-attributes AttributeKey=EventName,AttributeValue=<event>
aws ec2 describe-security-groups --group-ids <sg-id>
aws ec2 describe-route-tables --filters Name=vpc-id,Values=<vpc-id>
```
