#!/bin/bash

# Path to your game repository
REPO_PATH="$HOME/mystical_adventure_game"

# Log file for tracking script output
LOG_FILE="$HOME/auto_commit_log.txt"

# Navigate to the repository path
cd "$REPO_PATH" || { echo "[ERROR] Failed to change directory to $REPO_PATH" | tee -a "$LOG_FILE"; exit 1; }

# Add all changes
git add . >> "$LOG_FILE" 2>&1

# Check if there are changes to commit
if ! git diff-index --quiet HEAD; then
    # Commit the changes
    COMMIT_MESSAGE="Automated Backup Commit: $(date)"
    git commit -m "$COMMIT_MESSAGE" >> "$LOG_FILE" 2>&1

    # Pull the latest changes from remote to avoid conflicts
    echo "[INFO] Pulling latest changes from GitHub..." | tee -a "$LOG_FILE"
    if git pull origin main --rebase --strategy-option theirs >> "$LOG_FILE" 2>&1; then
        # Retry mechanism for pushing changes
        PUSH_ATTEMPTS=0
        MAX_ATTEMPTS=3
        while [ $PUSH_ATTEMPTS -lt $MAX_ATTEMPTS ]; do
            if git push origin main >> "$LOG_FILE" 2>&1; then
                echo "[INFO] Push completed successfully." | tee -a "$LOG_FILE"
                break
            else
                ((PUSH_ATTEMPTS++))
                echo "[WARNING] Push attempt $PUSH_ATTEMPTS failed. Retrying..." | tee -a "$LOG_FILE"
                sleep 5
            fi
        done

        if [ $PUSH_ATTEMPTS -eq $MAX_ATTEMPTS ]; then
            echo "[ERROR] Failed to push changes after $MAX_ATTEMPTS attempts." | tee -a "$LOG_FILE"
        fi
    else
        # If rebase failed, provide instructions for manual conflict resolution
        echo "[ERROR] Rebase failed. Please resolve conflicts manually." | tee -a "$LOG_FILE"
        exit 1
    fi
else
    echo "[INFO] No changes to commit." | tee -a "$LOG_FILE"
fi
#!/bin/bash

# Set path to your local repository
cd "/home/dude/mystical_adventure_game"

# Step 1: Add all changes
git add .

# Step 2: Commit with timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
git commit -m "Automated Backup Commit: $TIMESTAMP"

# Step 3: Push to GitHub
git push origin main

echo "Backup commit completed."
