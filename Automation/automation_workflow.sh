#!/bin/bash

# Define paths
SCENE_CREATOR="/home/dude/mystical_adventure_game/Automation/scene_creator.sh"
LOG_FILE="/home/dude/mystical_adventure_game/Automation/automation_log.txt"

# Log start of automation
echo "$(date '+%Y-%m-%d %H:%M:%S') : Starting game build automation..." >> "$LOG_FILE"

# Step 1: Generate new scenes
SCENE_NAME="NewScene_$(date '+%Y%m%d_%H%M%S')"
if [[ -x "$SCENE_CREATOR" ]]; then
    bash "$SCENE_CREATOR" "$SCENE_NAME" >> "$LOG_FILE" 2>&1
    if [[ $? -eq 0 ]]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') : Scene '$SCENE_NAME' generation completed." >> "$LOG_FILE"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') : Error: Scene generation failed!" >> "$LOG_FILE"
    fi
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') : Scene creator script not found or not executable!" >> "$LOG_FILE"
fi

# Step 2: Log completion
echo "$(date '+%Y-%m-%d %H:%M:%S') : Automation workflow completed." >> "$LOG_FILE"
