#!/bin/bash

# Paths
UNITY_EXECUTABLE="/home/dude/Unity/Hub/Editor/6000.0.28f1/Editor/Unity" # Path to Unity Editor
PROJECT_PATH="/home/dude/project_workspace/mystical_adventure_game"
LOG_DIR="$PROJECT_PATH/Logs"
LOG_FILE="$LOG_DIR/asset_management_$(date '+%Y%m%d_%H%M%S').log"

# Create log directory if not exists
mkdir -p "$LOG_DIR"

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

log "[INFO] Starting automated asset management tasks..."

# Validate Asset Paths
log "[INFO] Validating asset paths..."
ASSET_PATHS=("Assets/Scenes/ProceduralScene.unity" "Assets/GeneratedMaterials")
MISSING_ASSETS=0

for path in "${ASSET_PATHS[@]}"; do
    if [ ! -e "$PROJECT_PATH/$path" ]; then
        log "[ERROR] Missing asset path: $path"
        MISSING_ASSETS=$((MISSING_ASSETS + 1))
    else
        log "[INFO] Valid asset path: $path"
    fi
done

if [ "$MISSING_ASSETS" -gt 0 ]; then
    log "[ERROR] $MISSING_ASSETS assets missing. Aborting."
    exit 1
else
    log "[INFO] All asset paths validated successfully."
fi

# Run Unity in Batch Mode for Asset Generation
log "[INFO] Running Unity Batchmode for asset generation..."

"$UNITY_EXECUTABLE" -batchmode -quit \
    -projectPath "$PROJECT_PATH" \
    -executeMethod MysticalAdventure.AssetManager.GenerateAssets >> "$LOG_FILE" 2>&1

if [ $? -ne 0 ]; then
    log "[ERROR] Unity asset generation failed. Aborting."
    exit 1
else
    log "[INFO] Asset generation completed successfully."
fi

# Check Scene Configuration
log "[INFO] Verifying scenes in Build Settings..."
SCENES=("Assets/Scenes/ProceduralScene.unity")
SCENES_FOUND=0

for scene in "${SCENES[@]}"; do
    if grep -q "$scene" "$PROJECT_PATH/ProjectSettings/EditorBuildSettings.asset"; then
        log "[INFO] Scene added to Build Settings: $scene"
        SCENES_FOUND=$((SCENES_FOUND + 1))
    else
        log "[WARNING] Scene not found in Build Settings: $scene. Adding it..."
        "$UNITY_EXECUTABLE" -batchmode -quit \
            -projectPath "$PROJECT_PATH" \
            -executeMethod MysticalAdventure.SceneManager.AddSceneToBuildSettings "$scene" >> "$LOG_FILE" 2>&1
    fi
done

if [ "$SCENES_FOUND" -ne "${#SCENES[@]}" ]; then
    log "[WARNING] Some scenes were not in Build Settings and were added."
else
    log "[INFO] All required scenes are in Build Settings."
fi

# Run Tests
log "[INFO] Running Unity tests..."
"$UNITY_EXECUTABLE" -batchmode -runTests \
    -projectPath "$PROJECT_PATH" \
    -testResults "$LOG_DIR/test_results.xml" >> "$LOG_FILE" 2>&1

if [ $? -ne 0 ]; then
    log "[ERROR] Tests failed. Check $LOG_DIR/test_results.xml for details."
    exit 1
else
    log "[INFO] All tests passed successfully."
fi

# Cleanup old logs (optional)
log "[INFO] Cleaning up old logs..."
find "$LOG_DIR" -type f -mtime +7 -exec rm -f {} \;
log "[INFO] Old logs cleaned up."

log "[INFO] Asset management tasks completed successfully."

