#/bin/bash /home/dude/ReliefCrew.sh /home/dude/mystical_adventure_game
SCENE_NAME=$1
SCENES_DIR="/home/dude/mystical_adventure_game/Scenes"
LOG_FILE="/home/dude/mystical_adventure_game/Automation/scene_creation_log.txt"
[ -z "$SCENE_NAME" ] && echo "Usage: ./scene_creator.sh [scene_name]" && exit 1

echo "$(date) : [INFO] Creating new scene: $SCENE_NAME" >> "$LOG_FILE"
touch "$SCENES_DIR/$SCENE_NAME.unity"
