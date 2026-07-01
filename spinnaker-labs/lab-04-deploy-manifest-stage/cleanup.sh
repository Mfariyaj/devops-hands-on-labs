#!/bin/bash
# Lab 04: Deploy Manifest Stage - Cleanup Script

LAB_DIR="/tmp/spinnaker-lab-04"

echo "🧹 Cleaning up Lab 04: Deploy Manifest Stage"
rm -rf "$LAB_DIR"
kubectl delete namespace production-ns --ignore-not-found 2>/dev/null || true
echo "✅ Cleaned up Lab 04"
