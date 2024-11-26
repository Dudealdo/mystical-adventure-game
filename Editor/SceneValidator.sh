#!/bin/bash

# Set the path to the Unity Editor executable (not the Editor folder itself)
UNITY_PATH="/home/dude/Unity/Hub/Editor/6000.0.27f1/Editor/Unity"

# Set the path to your Unity project
PROJECT_PATH="/home/dude/mystical_adventure_game"

# Set the path to the SceneValidator script (relative to the project)
SCENE_VALIDATOR_SCRIPT="Assets/Editor/SceneValidator.cs"

# Run Unity in batch mode, executing the ValidateScenes method from the SceneValidator script
$UNITY_PATH -batchmode -quit -projectPath "$PROJECT_PATH" -executeMethod SceneValidator.ValidateScenes

echo "Scene validation completed."

