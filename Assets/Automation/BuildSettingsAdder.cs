using UnityEditor;
using UnityEngine;
using System.Linq;  // Import LINQ for Contains and Concat methods

public class BuildSettingsAdder
{
    [MenuItem("Tools/Add Scenes to Build Settings")]
    public static void AddScenesToBuildSettings()
    {
        // List of scenes you want to add to Build Settings
        string[] scenePaths = {
            "Assets/Scenes/NewScene_20241125_050002.unity", 
            "Assets/Scenes/NewScene_20241125_050003.unity"
        };

        // Get the current scenes in Build Settings
        EditorBuildSettingsScene[] currentScenes = EditorBuildSettings.scenes;

        foreach (string scene in scenePaths)
        {
            // Check if the scene is already in the Build Settings
            if (!currentScenes.Any(s => s.path == scene))
            {
                // Add the scene to the Build Settings array
                EditorBuildSettingsScene newScene = new EditorBuildSettingsScene(scene, true);
                EditorBuildSettings.scenes = currentScenes.Concat(new[] { newScene }).ToArray();
                Debug.Log($"Scene '{scene}' added to Build Settings.");
            }
            else
            {
                Debug.Log($"Scene '{scene}' is already in Build Settings. Skipping.");
            }
        }
    }
}

