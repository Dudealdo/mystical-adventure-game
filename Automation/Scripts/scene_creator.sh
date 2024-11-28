#!/bin/bash
SCENE_NAME=$1
SCENES_DIR="/home/dude/mystical_adventure_game/Scenes"
LOG_FILE="/home/dude/mystical_adventure_game/Automation/scene_creation_log.txt"
if [ -z "$SCENE_NAME" ]; then
    echo "Usage: ./scene_creator.sh [scene_name]"
    exit 1
fi

echo "$(date) : [INFO] Creating new scene: $SCENE_NAME" >> "$LOG_FILE"
touch "$SCENES_DIR/$SCENE_NAME.unity"
