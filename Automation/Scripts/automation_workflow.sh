#!/bin/bash

# Automation Workflow

# Paths
PROJECT_PATH="/home/dude/project_workspace/mystical_adventure_game"
AUTOMATION_PATH="$PROJECT_PATH/Automation"
LOG_PATH="$AUTOMATION_PATH/Logs"
SCRIPTS_PATH="$AUTOMATION_PATH/Scripts"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$LOG_PATH/automation_log_$(date '+%Y%m%d').txt"
}

# Step 1: Scene creation
log "Running scene creation..."
bash "$SCRIPTS_PATH/scene_creator.sh"

# Step 2: Scene recycling
log "Running scene recycling..."
bash "$SCRIPTS_PATH/scene_recycling.sh"

# Step 3: Proximity triggers
log "Running proximity triggers..."
bash "$SCRIPTS_PATH/proximity_trigger.sh"

# Step 4: Time triggers
log "Running time triggers..."
bash "$SCRIPTS_PATH/time_trigger.sh"

log "Automation workflow completed."

