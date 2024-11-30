#!/bin/bash

# Paths
PROJECT_ROOT="/home/dude/project_workspace/mystical_adventure_game"
SCRIPTS_PATH="$PROJECT_ROOT/Automation/Scripts"
LOG_FILE="$PROJECT_ROOT/integration_log.txt"

# Initialize log
echo "Integration Process Started - $(date)" > "$LOG_FILE"

# Step 1: Setting up directory structure
echo "Step 1: Setting up directory structure..." | tee -a "$LOG_FILE"
mkdir -p "$SCRIPTS_PATH" "$PROJECT_ROOT/Builds" "$PROJECT_ROOT/Assets"
echo "Directory structure set up successfully." | tee -a "$LOG_FILE"

# Step 2: Validating automation scripts
echo "Step 2: Validating automation scripts..." | tee -a "$LOG_FILE"

declare -a required_scripts=("setup_unity_license.sh" "other_required_script.sh")
for script in "${required_scripts[@]}"; do
    if [ ! -f "$SCRIPTS_PATH/$script" ]; then
        echo "Error: Missing script $script in $SCRIPTS_PATH" | tee -a "$LOG_FILE"
        # Create a placeholder for missing scripts
        echo "#!/bin/bash" > "$SCRIPTS_PATH/$script"
        echo "echo \"$script is a placeholder.\"" >> "$SCRIPTS_PATH/$script"
        chmod +x "$SCRIPTS_PATH/$script"
        echo "$script placeholder created." | tee -a "$LOG_FILE"
    else
        echo "$script validated." | tee -a "$LOG_FILE"
    fi
done

# Step 3: Unity license validation
echo "Step 3: Validating Unity license..." | tee -a "$LOG_FILE"
LICENSE_PATH="$PROJECT_ROOT/Unity_v6000.0.27f1.alf"
if [ -f "$LICENSE_PATH" ]; then
    echo "Unity license found at $LICENSE_PATH" | tee -a "$LOG_FILE"
else
    echo "Error: Unity license file missing at $LICENSE_PATH. Aborting." | tee -a "$LOG_FILE"
    exit 1
fi

# Step 4: GitHub secrets setup
echo "Step 4: Setting up GitHub secrets..." | tee -a "$LOG_FILE"
if command -v gh > /dev/null; then
    gh secret set UNITY_LICENSE < "$LICENSE_PATH" 2>> "$LOG_FILE"
    if [ $? -eq 0 ]; then
        echo "GitHub secret for Unity license configured successfully." | tee -a "$LOG_FILE"
    else
        echo "Error: Failed to configure GitHub secret for Unity license." | tee -a "$LOG_FILE"
    fi
else
    echo "Error: GitHub CLI (gh) not installed or configured. Skipping secrets setup." | tee -a "$LOG_FILE"
fi

# Final Step: Log completion
echo "Integration Process Completed - $(date)" | tee -a "$LOG_FILE"

