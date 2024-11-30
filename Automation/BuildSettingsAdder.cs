using UnityEditor;
using UnityEngine;

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

        foreach (string scene in scenePaths)
        {
            // Check if the scene is already in Build Settings
            if (!EditorBuildSettings.scenes.Contains(new EditorBuildSettingsScene(scene, true)))
            {
                // Add the scene to Build Settings
                EditorBuildSettings.scenes = EditorBuildSettings.scenes.Concat(new[] { new EditorBuildSettingsScene(scene, true) }).ToArray();
            }
        }
        Debug.Log("Scenes added to Build Settings.");
    }
}

