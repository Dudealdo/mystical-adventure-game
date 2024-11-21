#!/bin/bash

# Verify SSH connection to GitHub
SSH_CONNECTION_SUCCESS=false
for i in {1..3}; do
  echo "[INFO] Verifying SSH connection to GitHub (attempt $i)..."
  ssh -o BatchMode=yes -T git@github.com
  if [ $? -eq 1 ] || [ $? -eq 255 ]; then
    SSH_CONNECTION_SUCCESS=true
    break
  else
    echo "[ERROR] Unable to connect to GitHub via SSH. Please check your SSH key setup."
    echo "[INFO] Waiting for additional time to add the SSH key to GitHub..."
    sleep 30
  fi
done

if [ "$SSH_CONNECTION_SUCCESS" = false ]; then
  echo "[ERROR] SSH connection failed after multiple attempts. Exiting script."
  exit 1
fi
