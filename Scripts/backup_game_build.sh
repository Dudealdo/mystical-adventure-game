#!/bin/bash

# Backup Game Build to External Hard Drive
# This script automates saving the game build to your external hard drive.

# Configuration Variables
GAME_BUILD_PATH="$HOME/mystical_adventure_game"  # Path to your game build directory
EXTERNAL_DRIVE_UUID="1983ccb4-8604-4443-b5b8-e552056f868b"  # UUID of your external hard drive
EXTERNAL_DRIVE_PATH="/media/dude/$EXTERNAL_DRIVE_UUID"  # Path to your external hard drive
BACKUP_PATH="$EXTERNAL_DRIVE_PATH/game_build_backup"  # Destination for backup

# Log file for backup process
LOG_FILE="/home/dude/backup_log.txt"

# Step 1: Verify that the external hard drive is mounted, and mount it if necessary
if [ ! -d "$EXTERNAL_DRIVE_PATH" ]; then
    echo "$(date) : [INFO] External drive not mounted. Attempting to mount." >> "$LOG_FILE"
    # Create mount point if it doesn't exist
    [ ! -d "/media/dude/$EXTERNAL_DRIVE_UUID" ] && mkdir -p "/media/dude/$EXTERNAL_DRIVE_UUID"
    # Attempt to mount the drive
    sudo mount -U "$EXTERNAL_DRIVE_UUID" "$EXTERNAL_DRIVE_PATH" >> "$LOG_FILE" 2>&1
    if [ $? -ne 0 ]; then
        echo "$(date) : [ERROR] Failed to mount external drive. Exiting." >> "$LOG_FILE"
        exit 1
    fi
    echo "$(date) : [INFO] Successfully mounted external drive at $EXTERNAL_DRIVE_PATH" >> "$LOG_FILE"
fi

# Step 2: Create a backup folder if it doesn't exist
if [ ! -d "$BACKUP_PATH" ]; then
    echo "$(date) : [INFO] Creating backup folder at $BACKUP_PATH" >> "$LOG_FILE"
    mkdir -p "$BACKUP_PATH"
fi

# Step 3: Copy game build files to external hard drive
echo "$(date) : [INFO] Starting game build backup to external hard drive." >> "$LOG_FILE"
rsync -avh --delete "$GAME_BUILD_PATH/" "$BACKUP_PATH/" >> "$LOG_FILE" 2>&1

# Step 4: Log backup completion
if [ $? -eq 0 ]; then
    echo "$(date) : [INFO] Game build backup completed successfully." >> "$LOG_FILE"
else
    echo "$(date) : [ERROR] Game build backup failed." >> "$LOG_FILE"
fi
