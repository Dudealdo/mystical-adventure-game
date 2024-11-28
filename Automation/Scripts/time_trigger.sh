#/bin/bash /home/dude/ReliefCrew.sh /home/dude/mystical_adventure_game
TRIGGER_NAME=$1
WAIT_TIME=$2
LOG_FILE="/home/dude/mystical_adventure_game/Automation/time_trigger_log.txt"
[ -z "$TRIGGER_NAME" ] || [ -z "$WAIT_TIME" ] && echo "Usage: ./time_trigger.sh [trigger_name] [wait_time_seconds]" && exit 1

echo "$(date) : [INFO] Waiting for $WAIT_TIME seconds to activate $TRIGGER_NAME." >> "$LOG_FILE"
sleep $WAIT_TIME
echo "$(date) : [INFO] Time-based trigger $TRIGGER_NAME activated." >> "$LOG_FILE"
