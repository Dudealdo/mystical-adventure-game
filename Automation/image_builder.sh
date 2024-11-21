#!/bin/bash
ASSETS_DIR="/home/dude/mystical_adventure_game/Assets"
OUTPUT_DIR="$ASSETS_DIR/GeneratedImages"
LOG_FILE="$ASSETS_DIR/image_generation_log.txt"

mkdir -p "$OUTPUT_DIR"
echo "$(date) : [INFO] Starting image generation." >> "$LOG_FILE"

# Update the input image path to the existing test image
INPUT_IMAGE="$ASSETS_DIR/test_image.png"
OUTPUT_IMAGE="$OUTPUT_DIR/output.png"

convert "$INPUT_IMAGE" -resize 50% "$OUTPUT_IMAGE" || {
    echo "$(date) : [ERROR] Image generation failed." >> "$LOG_FILE"; exit 1;
}

echo "$(date) : [INFO] Image generation completed." >> "$LOG_FILE"

