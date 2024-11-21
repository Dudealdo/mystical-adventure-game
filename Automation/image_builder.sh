#!/bin/bash
ASSETS_DIR="/home/dude/mystical_adventure_game/Assets"
OUTPUT_DIR="$ASSETS_DIR/GeneratedImages"
LOG_FILE="$ASSETS_DIR/image_generation_log.txt"
mkdir -p "$OUTPUT_DIR"
echo "$(date) : [INFO] Starting image generation." >> "$LOG_FILE"
convert /path/to/input.png -resize 50% "$OUTPUT_DIR/output.png"
echo "$(date) : [INFO] Image generation completed." >> "$LOG_FILE"
