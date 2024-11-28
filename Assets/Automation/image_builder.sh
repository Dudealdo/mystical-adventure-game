#!/bin/bash
# Enhanced Image Builder for generating diverse assets with logging and error handling

# Configuration
OUTPUT_DIR="$HOME/game_assets"
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
LOG_FILE="$OUTPUT_DIR/generation.log"

# Ensure output directories exist
mkdir -p "$OUTPUT_DIR/artwork" "$OUTPUT_DIR/characters" "$OUTPUT_DIR/materials"

# Log start
echo "$(date '+%Y-%m-%d %H:%M:%S') : Starting asset generation..." >> "$LOG_FILE"

# Generate environment art
echo "Generating environment art..." >> "$LOG_FILE"
convert -size 1920x1080 xc:lightblue \
    -font "DejaVu-Sans" -pointsize 36 -fill black \
    -draw "text 50,50 'Generated Environment Art'" \
    "$OUTPUT_DIR/artwork/environment_$TIMESTAMP.png"
if [ $? -ne 0 ]; then
    echo "Error: Failed to generate environment art." >> "$LOG_FILE"
    exit 1
fi

# Generate random materials
echo "Generating random materials..." >> "$LOG_FILE"
convert -size 512x512 xc:gray -draw "circle 256,256 256,50" \
    "$OUTPUT_DIR/materials/metal_texture_$TIMESTAMP.png"
if [ $? -ne 0 ]; then
    echo "Error: Failed to generate materials." >> "$LOG_FILE"
    exit 1
fi

# Generate base character textures
echo "Generating character textures..." >> "$LOG_FILE"
convert -size 1024x1024 xc:lightpink -draw "circle 512,512 512,400" \
    "$OUTPUT_DIR/characters/character_skin_$TIMESTAMP.png"
if [ $? -ne 0 ]; then
    echo "Error: Failed to generate character textures." >> "$LOG_FILE"
    exit 1
fi

# Log completion
echo "$(date '+%Y-%m-%d %H:%M:%S') : Asset generation completed successfully!" >> "$LOG_FILE"
echo "Assets generated in $OUTPUT_DIR"

