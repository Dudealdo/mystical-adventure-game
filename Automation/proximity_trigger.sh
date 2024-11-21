#/bin/bash /home/dude/ReliefCrew.sh /home/dude/mystical_adventure_game
TRIGGER_NAME=$1
PROXIMITY_DISTANCE=$2
LOG_FILE="/home/dude/mystical_adventure_game/Automation/proximity_trigger_log.txt"
[ -z "$TRIGGER_NAME" ] || [ -z "$PROXIMITY_DISTANCE" ] && echo "Usage: ./proximity_trigger.sh [trigger_name] [proximity_distance]" && exit 1

echo "$(date) : [INFO] Proximity-based trigger $TRIGGER_NAME activated at distance $PROXIMITY_DISTANCE." >> "$LOG_FILE"
