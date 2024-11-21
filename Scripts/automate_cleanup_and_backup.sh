#!/bin/bash
BACKUP_PATH="/media/dude/1983ccb4-8604-4443-b5b8-e552056f868b/game_build_backup"
LOG_FILE="/home/dude/mystical_adventure_game/Automation/cleanup_and_backup_log.txt"
echo "$(date) : [INFO] Starting cleanup and backup process." >> "$LOG_FILE"
find "/home/dude/mystical_adventure_game" -name "*.log" -type f -delete
echo "$(date) : [INFO] Cleanup completed." >> "$LOG_FILE"
rsync -av --exclude='.git' "/home/dude/mystical_adventure_game/" "$BACKUP_PATH/" >> "$LOG_FILE" 2>&1
