#!/bin/bash
# Lab 05: Canary Analysis Failure - Cleanup Script

LAB_DIR="/tmp/spinnaker-lab-05"

echo "🧹 Cleaning up Lab 05: Canary Analysis Failure"
rm -rf "$LAB_DIR"
kubectl delete deployment myapp-canary -n production --ignore-not-found 2>/dev/null || true
kubectl delete deployment myapp-baseline -n production --ignore-not-found 2>/dev/null || true
echo "✅ Cleaned up Lab 05"
