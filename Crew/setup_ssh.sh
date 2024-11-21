#!/bin/bash

# Configure GitHub SSH authentication
SSH_KEY_PATH="/home/dude/.ssh/id_rsa_github"
if [ ! -f "$SSH_KEY_PATH" ]; then
  echo "[INFO] Generating new SSH key..."
  ssh-keygen -t ed25519 -C "Dudealdo@github.com" -f "$SSH_KEY_PATH" -N ""
  eval "$(ssh-agent -s)"
  ssh-add "$SSH_KEY_PATH"
  echo "[INFO] Please add the following SSH key to your GitHub account:"
  cat "$SSH_KEY_PATH.pub"
  echo "[INFO] Waiting for SSH key to be added to GitHub..."
  sleep 30  # Extended wait time to add the SSH key before proceeding
else
  eval "$(ssh-agent -s)"
  ssh-add "$SSH_KEY_PATH"
fi

# Automatically add GitHub to known hosts
ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts 2>/dev/null
