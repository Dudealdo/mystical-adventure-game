#!/bin/bash

# Master Automation Manager

# Paths
UNITY_PATH="/home/dude/Unity/Hub/Editor/6000.0.27f1/Editor/Unity"
PROJECT_PATH="/home/dude/project_workspace/mystical_adventure_game"
AUTOMATION_PATH="$PROJECT_PATH/Assets/Automation"
LOG_PATH="$PROJECT_PATH/Logs"
GENERATED_MATERIALS_PATH="$PROJECT_PATH/Assets/GeneratedMaterials"
GAME_ASSETS_PATH="$HOME/game_assets"

# Create necessary directories
echo "Validating directory structure..."
mkdir -p "$AUTOMATION_PATH"
mkdir -p "$LOG_PATH"
mkdir -p "$GENERATED_MATERIALS_PATH"
mkdir -p "$GAME_ASSETS_PATH/artwork" "$GAME_ASSETS_PATH/characters" "$GAME_ASSETS_PATH/materials"
echo "Directory structure validated."

# Validate scripts
echo "Validating automation scripts..."
SCRIPTS=("image_builder.sh" "BackgroundRepairCrew.sh" "MaterialGenerator.cs" "MenuDebugger.cs" "AutomationUtils.cs")
for script in "${SCRIPTS[@]}"; do
    if [ ! -f "$AUTOMATION_PATH/$script" ]; then
        echo "Error: Missing script $script in $AUTOMATION_PATH"
        exit 1
    fi
done
echo "All scripts validated."

# Log initialization
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
LOG_FILE="$LOG_PATH/master_automation_$TIMESTAMP.log"
touch "$LOG_FILE"

# Helper function for logging
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" | tee -a "$LOG_FILE"
}

# Step 1: Run image builder
log "Running Image Builder..."
bash "$AUTOMATION_PATH/image_builder.sh" >> "$LOG_FILE" 2>&1
if [ $? -ne 0 ]; then
    log "Error: Image Builder failed. Check logs for details."
    exit 1
fi
log "Image Builder completed successfully."

# Step 2: Run Background Repair Crew
log "Running Background Repair Crew..."
bash "$AUTOMATION_PATH/BackgroundRepairCrew.sh" >> "$LOG_FILE" 2>&1
if [ $? -ne 0 ]; then
    log "Error: Background Repair Crew encountered issues. Check logs for details."
    exit 1
fi
log "Background Repair Crew completed successfully."

# Step 3: Generate materials in Unity
log "Running Material Generator in Unity..."
"$UNITY_PATH" -quit -batchmode -projectPath "$PROJECT_PATH" -executeMethod MyGameAutomation.MaterialGenerator.GenerateMaterials >> "$LOG_FILE" 2>&1
if [ $? -ne 0 ]; then
    log "Error: Material Generator failed. Check Unity logs for details."
    exit 1
fi
log "Material Generator completed successfully."

# Step 4: Refresh Unity assets
log "Refreshing Unity assets..."
"$UNITY_PATH" -quit -batchmode -projectPath "$PROJECT_PATH" -executeMethod MyGameAutomation.AutomationUtils.RefreshAssets >> "$LOG_FILE" 2>&1
if [ $? -ne 0 ]; then
    log "Error: Asset refresh failed. Check Unity logs for details."
    exit 1
fi
log "Unity assets refreshed successfully."

# Final status
log "Master automation workflow completed successfully!"
echo "Logs saved to $LOG_FILE"

