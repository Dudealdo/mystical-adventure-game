#!/bin/bash
# Pre-push script to check for uncommitted changes
echo "[INFO] Running pre-push check script..."

if ! git diff-index --quiet HEAD --; then
    echo "[ERROR] Uncommitted changes detected. Please commit or stash your changes before pushing."
    exit 1
fi

echo "[INFO] Pre-push check passed. Proceeding with push."
