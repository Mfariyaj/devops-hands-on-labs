#!/bin/bash
# Lab 14: Managed Pipeline Delivery - Cleanup Script

LAB_DIR="/tmp/spinnaker-lab-14"

echo "🧹 Cleaning up Lab 14: Managed Pipeline Delivery"
rm -rf "$LAB_DIR"

# Remove managed delivery config from Spinnaker
curl -X DELETE http://localhost:8084/managed/delivery-configs/myapp 2>/dev/null || true

echo "✅ Cleaned up Lab 14"
