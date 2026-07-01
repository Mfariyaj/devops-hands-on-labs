#!/bin/bash
# Lab 02: Clouddriver K8s Account - Deploy Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=============================================="
echo "  🎯 Spinnaker Lab 02: Clouddriver K8s Account"
echo "=============================================="
echo ""
echo "  Scenario: Clouddriver can't connect to the"
echo "  Kubernetes cluster. Deployments fail with"
echo "  authentication and connection errors."
echo ""
echo "  Your task: Fix the Clouddriver configuration,"
echo "  kubeconfig, and RBAC to restore connectivity."
echo ""
echo "=============================================="
echo ""

LAB_DIR="/tmp/spinnaker-lab-02"
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"

cp "$SCRIPT_DIR/clouddriver-local.yml" "$LAB_DIR/"
cp "$SCRIPT_DIR/kubeconfig-broken.yaml" "$LAB_DIR/"
cp "$SCRIPT_DIR/rbac.yaml" "$LAB_DIR/"

echo "📁 Broken configs deployed to: $LAB_DIR/"
echo ""
echo "  Files to investigate:"
echo "    - $LAB_DIR/clouddriver-local.yml"
echo "    - $LAB_DIR/kubeconfig-broken.yaml"
echo "    - $LAB_DIR/rbac.yaml"
echo ""
echo "  Start by checking the context names and server URL"
echo ""
