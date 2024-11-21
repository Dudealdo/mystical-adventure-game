#!/bin/bash

# Push changes to GitHub
echo "[INFO] Pushing changes to GitHub..."
if ! git push origin main; then
  echo "[ERROR] Git push failed. Please ensure you have the correct access rights."
  exit 1
fi
