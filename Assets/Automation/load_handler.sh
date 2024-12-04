#!/bin/bash

# Paths
UNITY_EXECUTABLE="/home/dude/Unity/Hub/Editor/6000.0.28f1/Editor/Unity"
UNITY_PROJECT_PATH="/home/dude/project_workspace/mystical_adventure_game"
LOG_DIR="/home/dude/project_workspace/mystical_adventure_game/Logs"
LOG_FILE="$LOG_DIR/load_handler_$(date '+%Y%m%d_%H%M%S').log"

# Ensure log directory exists
mkdir -p "$LOG_DIR"

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Start of the script
log "[INFO] Starting Unity Enhanced Load Handler operations..."

# Check system load
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEM_LOAD=$(free | grep Mem | awk '{printf "%.2f", $3/$2 * 100.0}')

log "[INFO] Current CPU Load: ${CPU_LOAD}%"
log "[INFO] Current Memory Load: ${MEM_LOAD}%"

# Run Unity in batch mode for asset generation
log "[INFO] Running Unity Batchmode for asset management..."
"$UNITY_EXECUTABLE" -batchmode -quit \
    -projectPath "$UNITY_PROJECT_PATH" \
    -executeMethod MysticalAdventure.AssetManager.GenerateAssets >> "$LOG_FILE" 2>&1

if [ $? -eq 0 ]; then
    log "[INFO] Asset generation completed successfully."
else
    log "[ERROR] Unity asset management failed. Check the Unity log for details."
    tail -n 20 "$LOG_FILE"  # Show last 20 lines for quick debugging
    exit 1
fi

# Cleanup old logs
log "[INFO] Cleaning up old log files..."
find "$LOG_DIR" -type f -mtime +7 -exec rm -f {} \;
log "[INFO] Old logs cleaned up."

# End of script
log "[INFO] Unity Enhanced Load Handler operations completed successfully."
exit 0

