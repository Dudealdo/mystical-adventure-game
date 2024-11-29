#!/bin/bash

# Paths and Variables
UNITY_LICENSE_PATH="/home/dude/.local/share/unity3d/Unity/Unity_lic.ulf"
GITHUB_WORKFLOW_PATH=".github/workflows/build.yml"

# Check if the Unity license file exists
if [ ! -f "$UNITY_LICENSE_PATH" ]; then
    echo "Error: Unity license file not found at $UNITY_LICENSE_PATH"
    exit 1
fi

# Add Unity license secret to GitHub
echo "Configuring Unity license secret for GitHub..."
gh secret set UNITY_LICENSE -b "$(cat $UNITY_LICENSE_PATH)"
if [ $? -ne 0 ]; then
    echo "Failed to set GitHub secret for Unity license."
    exit 1
fi
echo "Unity license secret configured successfully."

# Verify or create GitHub workflow file
if [ ! -f "$GITHUB_WORKFLOW_PATH" ]; then
    echo "Creating GitHub workflow file..."
    mkdir -p "$(dirname "$GITHUB_WORKFLOW_PATH")"
    cat <<EOL > "$GITHUB_WORKFLOW_PATH"
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
          echo "\$UNITY_LICENSE" > unity.ulf
          mkdir -p ~/.local/share/unity3d/Unity/
          mv unity.ulf ~/.local/share/unity3d/Unity/Unity_lic.ulf

      - name: Run Unity Build
        uses: game-ci/unity-builder@v2
        with:
          unityVersion: "2022.3.53f1"
          targetPlatform: "StandaloneWindows64"

      - name: Upload Build Artifacts
        uses: actions/upload-artifact@v3
        with:
          name: GameBuild
          path: Builds/
EOL
    echo "GitHub workflow file created successfully."
else
    echo "GitHub workflow file already exists. Skipping creation."
fi

echo "Setup completed successfully."
