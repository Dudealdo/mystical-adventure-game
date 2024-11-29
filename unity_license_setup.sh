#!/bin/bash

# Define paths
ULF_FILE_PATH="/home/dude/.local/share/unity3d/Unity/Unity_lic.ulf"
GITHUB_REPO_URL="https://github.com/Dudealdo/mystical-adventure-game.git"

# Step 1: Validate the .ulf file existence
if [ ! -f "$ULF_FILE_PATH" ]; then
    echo "Error: Unity_lic.ulf file not found at $ULF_FILE_PATH."
    echo "Ensure the file exists before running the script."
    exit 1
fi

# Step 2: Add Unity license to GitHub secrets
echo "Configuring Unity license secret in GitHub..."
gh secret set UNITY_LICENSE -b "$(cat "$ULF_FILE_PATH")"
if [ $? -ne 0 ]; then
    echo "Error: Failed to add UNITY_LICENSE to GitHub secrets. Ensure you are authenticated with GitHub CLI."
    exit 1
fi
echo "Unity license secret successfully added to the GitHub repository."

# Step 3: Update GitHub Actions workflow
echo "Updating GitHub Actions workflow..."
WORKFLOW_FILE=".github/workflows/build.yml"
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
          echo "\$UNITY_LICENSE" > ~/.local/share/unity3d/Unity/Unity_lic.ulf

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

if [ $? -eq 0 ]; then
    echo "Workflow updated successfully."
else
    echo "Error: Failed to update the workflow file."
    exit 1
fi

# Step 4: Commit changes to the repository
echo "Pushing changes to the repository..."
git add $WORKFLOW_FILE
git commit -m "Added Unity license integration and build workflow"
git push origin main

if [ $? -eq 0 ]; then
    echo "Changes successfully pushed to the GitHub repository."
else
    echo "Error: Failed to push changes to the repository."
    exit 1
fi

echo "Setup completed successfully!"

