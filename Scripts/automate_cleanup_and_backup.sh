#/bin/bash /home/dude/ReliefCrew.sh /home/dude/mystical_adventure_game
BACKUP_PATH="/home/dude/game_build_backup"
LOG_FILE="/home/dude/mystical_adventure_game/Automation/cleanup_and_backup_log.txt"
echo "$(date) : [INFO] Starting cleanup and backup process." >> "$LOG_FILE"
find "/home/dude/mystical_adventure_game" -name "*.log" -type f -delete || {
    echo "$(date) : [ERROR] Cleanup process failed." >> "$LOG_FILE"; exit 1;
}
rsync -av --exclude='.git' "/home/dude/mystical_adventure_game/" "$BACKUP_PATH/" >> "$LOG_FILE" 2>&1 || {
    echo "$(date) : [ERROR] Backup process failed." >> "$LOG_FILE"; exit 1;
}
echo "$(date) : [INFO] Backup completed successfully." >> "$LOG_FILE"
