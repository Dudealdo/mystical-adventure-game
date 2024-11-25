#!/bin/bash

# Unity Path
UNITY_PATH="/home/dude/Unity/Hub/Editor/2022.3.53f1/Editor/Unity"

# Define paths
SCENE_CREATOR="/home/dude/mystical_adventure_game/Automation/scene_creator.sh"
LOG_FILE="/home/dude/mystical_adventure_game/Automation/automation_log.txt"

# Log start of automation
echo "$(date '+%Y-%m-%d %H:%M:%S') : Starting game build automation..." >> "$LOG_FILE"

# Step 1: Validate Scenes
echo "$(date '+%Y-%m-%d %H:%M:%S') : Validating scenes..." >> "$LOG_FILE"
if $UNITY_PATH -quit -batchmode -projectPath "/home/dude/mystical_adventure_game" -executeMethod SceneValidator.ValidateScenes >> "$LOG_FILE" 2>&1; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') : Scene validation completed successfully." >> "$LOG_FILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') : Error: Scene validation failed!" >> "$LOG_FILE"
fi

# Step 2: Build the Project
echo "$(date '+%Y-%m-%d %H:%M:%S') : Building the project..." >> "$LOG_FILE"
if $UNITY_PATH -quit -batchmode -projectPath "/home/dude/mystical_adventure_game" -buildTarget StandaloneLinux64 -executeMethod BuildPipeline.BuildPlayer >> "$LOG_FILE" 2>&1; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') : Build completed successfully." >> "$LOG_FILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') : Error: Build failed!" >> "$LOG_FILE"
fi

# Step 3: Generate new scenes
SCENE_NAME="NewScene_$(date '+%Y%m%d_%H%M%S')"
echo "$(date '+%Y-%m-%d %H:%M:%S') : Generating new scene: $SCENE_NAME..." >> "$LOG_FILE"
if [[ -x "$SCENE_CREATOR" ]]; then
    bash "$SCENE_CREATOR" "$SCENE_NAME" >> "$LOG_FILE" 2>&1
    if [[ $? -eq 0 ]]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') : Scene '$SCENE_NAME' generation completed." >> "$LOG_FILE"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') : Error: Scene generation failed!" >> "$LOG_FILE"
    fi
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') : Error: Scene creator script not found or not executable!" >> "$LOG_FILE"
fi

# Step 4: Log completion
echo "$(date '+%Y-%m-%d %H:%M:%S') : Automation workflow completed." >> "$LOG_FILE"

