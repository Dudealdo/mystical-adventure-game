#!/bin/bash

# === Configurable Variables ===
ULF_FILE_PATH="$HOME/.local/share/unity3d/Unity/Unity_lic.ulf"
WORKFLOW_FILE=".github/workflows/build.yml"
GITHUB_REPO_URL="https://github.com/Dudealdo/mystical-adventure-game.git"
UNITY_VERSION="2022.3.53f1"
TARGET_PLATFORM="StandaloneWindows64"
BUILD_ARTIFACT_NAME="GameBuild"
BUILD_PATH="Builds"

# === Helper Functions ===

# Exit on error and print the error message
function exit_on_error {
    echo "$1"
    exit 1
}

# Ensure the .ulf license file exists
function validate_license_file {
    echo "Validating Unity license file..."
    if [ ! -f "$ULF_FILE_PATH" ]; then
        exit_on_error "Error: Unity_lic.ulf file not found at $ULF_FILE_PATH. Ensure the file exists before running the script."
    fi
    echo "Unity license file validated successfully."
}

# Configure Unity license as a GitHub secret
function configure_github_secret {
    echo "Adding Unity license to GitHub secrets..."
    gh secret set UNITY_LICENSE -b "$(cat "$ULF_FILE_PATH")"
    if [ $? -ne 0 ]; then
        exit_on_error "Error: Failed to add UNITY_LICENSE to GitHub secrets. Ensure you are authenticated with the GitHub CLI."
    fi
    echo "Unity license secret successfully added."
}

# Create or update the GitHub Actions workflow
function update_github_workflow {
    echo "Creating or updating the GitHub Actions workflow..."
    mkdir -p $(dirname "$WORKFLOW_FILE")

    cat <<EOL > $WORKFLOW_FILE
name: Build Unity Project

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Set up Unity License
        env:
          UNITY_LICENSE: \${{ secrets.UNITY_LICENSE }}
        run: |
          mkdir -p ~/.local/share/unity3d/Unity/
          echo "\$UNITY_LICENSE" > ~/.local/share/unity


