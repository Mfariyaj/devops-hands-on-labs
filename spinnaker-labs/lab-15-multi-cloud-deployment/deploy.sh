#!/bin/bash
# Lab 15: Multi-Cloud Deployment - Deploy Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=============================================="
echo "  🎯 Spinnaker Lab 15: Multi-Cloud Deployment"
echo "=============================================="
echo ""
echo "  Scenario: A pipeline deploys to both K8s and AWS."
echo "  The AWS portion fails due to account name mismatch,"
echo "  wrong IAM AssumeRole ARN, and timeout too short."
echo ""
echo "  Your task: Fix multi-cloud pipeline config."
echo ""
echo "=============================================="
echo ""

LAB_DIR="/tmp/spinnaker-lab-15"
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"

cp "$SCRIPT_DIR/pipeline.json" "$LAB_DIR/"
cp "$SCRIPT_DIR/clouddriver-local.yml" "$LAB_DIR/"
cp "$SCRIPT_DIR/aws-account.json" "$LAB_DIR/"

echo "📁 Broken configs deployed to: $LAB_DIR/"
echo ""
echo "  Files to investigate:"
echo "    - pipeline.json (multi-cloud pipeline)"
echo "    - clouddriver-local.yml (AWS + K8s accounts)"
echo "    - aws-account.json (IAM role documentation)"
echo ""
