#!/bin/bash

# Master Automation Manager

# Paths
PROJECT_PATH="/home/dude/project_workspace/mystical_adventure_game"
AUTOMATION_PATH="$PROJECT_PATH/Automation"
LOG_PATH="$AUTOMATION_PATH/Logs"
SCRIPTS_PATH="$AUTOMATION_PATH/Scripts"

# Create necessary directories
echo "Setting up directory structure..."
mkdir -p "$LOG_PATH"
mkdir -p "$SCRIPTS_PATH"

# Consolidate logs
LOG_FILE="$LOG_PATH/automation_log_$(date '+%Y%m%d_%H%M%S').txt"
touch "$LOG_FILE"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" | tee -a "$LOG_FILE"
}

# Validate scripts
log "Validating automation scripts..."
SCRIPTS=("scene_creator.sh" "scene_recycling.sh" "proximity_trigger.sh" "time_trigger.sh")
for script in "${SCRIPTS[@]}"; do
    if [ ! -f "$SCRIPTS_PATH/$script" ]; then
        log "Error: Missing script $script in $SCRIPTS_PATH"
        exit 1
    fi
done
log "Scripts validated."

# Run automation workflow
log "Running automation workflow..."
bash "$SCRIPTS_PATH/automation_workflow.sh" >> "$LOG_FILE" 2>&1
log "Automation workflow completed."

