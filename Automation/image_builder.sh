#/bin/bash /home/dude/ReliefCrew.sh /home/dude/mystical_adventure_game
ASSETS_DIR="/home/dude/mystical_adventure_game/Assets"
OUTPUT_DIR="$ASSETS_DIR/GeneratedImages"
LOG_FILE="$ASSETS_DIR/image_generation_log.txt"
mkdir -p "$OUTPUT_DIR" || {
    echo "$(date) : [ERROR] Failed to create output directory." >> "$LOG_FILE"; exit 1;
}
echo "$(date) : [INFO] Starting image generation." >> "$LOG_FILE"
convert "$ASSETS_DIR/test_image.png" -resize 50% "$OUTPUT_DIR/output.png" || {
    echo "$(date) : [ERROR] Image generation failed." >> "$LOG_FILE"; exit 1;
}
echo "$(date) : [INFO] Image generation completed." >> "$LOG_FILE"
