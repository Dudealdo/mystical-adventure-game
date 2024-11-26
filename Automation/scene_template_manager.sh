#!/bin/bash

# Define directories and log file
GAME_DIR="$HOME/mystical_adventure_game"
TEMPLATES_DIR="$GAME_DIR/Templates"
SCENES_DIR="$GAME_DIR/Scenes"
LOG_FILE="$GAME_DIR/Automation/scene_template_log.txt"

# Ensure the Scenes directory exists
mkdir -p "$SCENES_DIR"

# Ensure Templates directory exists
if [ ! -d "$TEMPLATES_DIR" ]; then
  echo "$(date) : [ERROR] Templates directory not found ($TEMPLATES_DIR). Exiting." >> "$LOG_FILE"
  exit 1
fi

# Array of template types
declare -A templates
templates["BasicExploration"]="BasicExplorationScene.unity"
templates["PuzzleRoom"]="PuzzleRoomTemplate.unity"
templates["EncounterZone"]="EncounterZoneTemplate.unity"

# Loop through and create each scene template automatically
for template in "${!templates[@]}"; do
  TEMPLATE_FILE="$TEMPLATES_DIR/${templates[$template]}"
  SCENE_NAME="${template}_$(date +%Y%m%d_%H%M%S).unity"

  # Check if the template file exists
  if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "$(date) : [ERROR] Template '$template' not found at $TEMPLATE_FILE. Exiting." >> "$LOG_FILE"
    exit 1
  fi

  # Check if the scene already exists in the target directory
  if [ -f "$SCENES_DIR/$SCENE_NAME" ]; then
    echo "$(date) : [WARN] Scene '$SCENE_NAME' already exists. Skipping creation." >> "$LOG_FILE"
    continue
  fi

  # Copy the template to the Scenes directory
  cp -v "$TEMPLATE_FILE" "$SCENES_DIR/$SCENE_NAME"
  
  # Log success
  echo "$(date) : [INFO] Created $template Scene ($SCENE_NAME) from $TEMPLATE_FILE to $SCENES_DIR/$SCENE_NAME." >> "$LOG_FILE"
done

echo "$(date) : Scene templates generation process completed!" >> "$LOG_FILE"

