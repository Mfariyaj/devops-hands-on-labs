#!/bin/bash
# Lab 02: Clouddriver K8s Account - Cleanup Script

LAB_DIR="/tmp/spinnaker-lab-02"

echo "🧹 Cleaning up Lab 02: Clouddriver K8s Account"
rm -rf "$LAB_DIR"

# Remove RBAC resources if they were applied
kubectl delete clusterrolebinding spinnaker-deployer-binding --ignore-not-found 2>/dev/null || true
kubectl delete clusterrole spinnaker-deployer-role --ignore-not-found 2>/dev/null || true
kubectl delete sa spinnaker-deployer -n spinnaker --ignore-not-found 2>/dev/null || true

echo "✅ Cleaned up Lab 02"
