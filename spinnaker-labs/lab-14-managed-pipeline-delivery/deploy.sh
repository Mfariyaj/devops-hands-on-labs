#!/bin/bash
# Lab 14: Managed Pipeline Delivery - Deploy Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=============================================="
echo "  🎯 Spinnaker Lab 14: Managed Pipeline Delivery"
echo "=============================================="
echo ""
echo "  Scenario: Managed Delivery is configured but"
echo "  resources never converge. YAML format errors,"
echo "  constraint mismatches, and wrong references."
echo ""
echo "  Your task: Fix the delivery config so managed"
echo "  delivery can converge resources."
echo ""
echo "=============================================="
echo ""

LAB_DIR="/tmp/spinnaker-lab-14"
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"

cp "$SCRIPT_DIR/delivery-config.yml" "$LAB_DIR/"

echo "📁 Broken config deployed to: $LAB_DIR/delivery-config.yml"
echo ""
echo "  To submit to Spinnaker:"
echo "    curl -X POST http://gate:8084/managed/delivery-configs \\"
echo "      -H 'Content-Type: application/yaml' \\"
echo "      --data-binary @$LAB_DIR/delivery-config.yml"
echo ""
