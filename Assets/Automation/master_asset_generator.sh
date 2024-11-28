#!/bin/bash

# Master Asset Generator Script
echo "Starting Asset Generation Pipeline..."

# Step 1: Build Images
bash /home/dude/project_workspace/mystical_adventure_game/Assets/Automation/image_builder.sh

# Step 2: Generate Models
blender --background --python /home/dude/project_workspace/mystical_adventure_game/Assets/Automation/generate_character.py

# Step 3: Generate Unity Materials
/home/dude/Unity/Hub/Editor/6000.0.27f1/Editor/Unity -quit -batchmode -executeMethod MaterialGenerator.GenerateMaterials

echo "Asset Generation Complete!"

