#!/bin/bash
# Lab 13: Spinnaker Operator Crash - Cleanup Script

LAB_DIR="/tmp/spinnaker-lab-13"

echo "🧹 Cleaning up Lab 13: Spinnaker Operator Crash"
rm -rf "$LAB_DIR"
kubectl delete spinnakerservice spinnaker -n spinnaker --ignore-not-found 2>/dev/null || true
kubectl delete deployment spin-redis -n spinnaker --ignore-not-found 2>/dev/null || true
kubectl delete service spin-redis -n spinnaker --ignore-not-found 2>/dev/null || true
echo "✅ Cleaned up Lab 13"
