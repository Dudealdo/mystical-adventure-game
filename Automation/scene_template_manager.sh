#!/bin/bash

GAME_DIR="$HOME/mystical_adventure_game"
TEMPLATES_DIR="$GAME_DIR/Templates"
SCENES_DIR="$GAME_DIR/Scenes"
LOG_FILE="$GAME_DIR/Automation/scene_template_log.txt"

mkdir -p "$SCENES_DIR"

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
  if [ -f "$TEMPLATE_FILE" ]; then
    cp "$TEMPLATE_FILE" "$SCENES_DIR/$SCENE_NAME"
    echo "$(date) : [INFO] Created $template Scene ($SCENE_NAME)." >> "$LOG_FILE"
  else
    echo "$(date) : [ERROR] Template not found ($TEMPLATE_FILE)." >> "$LOG_FILE"
  fi
done

echo "Scene templates generation process completed!"
