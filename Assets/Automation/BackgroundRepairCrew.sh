#!/bin/bash

# Background Repair Crew Script

# Paths
UNITY_PATH="/home/dude/Unity/Hub/Editor/6000.0.27f1/Editor/Unity"
PROJECT_PATH="/home/dude/project_workspace/mystical_adventure_game"
LOG_PATH="$PROJECT_PATH/Logs"

# Create Logs Directory
mkdir -p "$LOG_PATH"

# Log Helper Function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOG_PATH/repair_crew.log"
}

# Start Repair Crew
log "Starting Background Repair Crew..."

# Check Unity Path
if [ ! -f "$UNITY_PATH" ]; then
    log "Error: Unity Editor not found at $UNITY_PATH."
    exit 1
fi

log "Unity Editor verified."

# Verify Project Directory
if [ ! -d "$PROJECT_PATH" ]; then
    log "Error: Project directory not found at $PROJECT_PATH."
    exit 1
fi

log "Unity project directory verified."

# Fix Permissions for Automation Scripts
AUTOMATION_PATH="$PROJECT_PATH/Assets/Automation"
for script in "$AUTOMATION_PATH"/*.sh; do
    if [ -f "$script" ]; then
        chmod +x "$script"
        log "Permissions updated for $script."
    fi
done

# Refresh Unity Assets
log "Attempting to refresh Unity assets..."
"$UNITY_PATH" -quit -batchmode -projectPath "$PROJECT_PATH" -executeMethod MyGameAutomation.AutomationUtils.RefreshAssets
if [ $? -ne 0 ]; then
    log "Error: Unity asset refresh failed. Check Unity logs."
    exit 1
fi

log "Unity assets refreshed successfully."
log "Background Repair Crew completed successfully!"

