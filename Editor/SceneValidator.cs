using UnityEditor;
using UnityEngine;

public class SceneValidator
{
    [MenuItem("Tools/Validate Scenes")]
    public static void ValidateScenes()
    {
        Debug.Log("Validating Scenes...");

        // Iterate through all scenes in the build settings
        foreach (var scene in EditorBuildSettings.scenes)
        {
            if (!scene.enabled)
            {
                Debug.LogWarning($"Scene {scene.path} is disabled in Build Settings and will not be validated.");
                continue;
            }

            Debug.Log($"Validating scene: {scene.path}");
            try
            {
                // Open the scene
                var sceneAsset = AssetDatabase.LoadAssetAtPath<SceneAsset>(scene.path);
                if (sceneAsset == null)
                {
                    Debug.LogError($"Scene {scene.path} could not be loaded.");
                    continue;
                }

                // Add additional scene validation logic here if needed
                Debug.Log($"Scene {scene.path} is valid.");
            }
            catch (System.Exception ex)
            {
                Debug.LogError($"Error validating scene {scene.path}: {ex.Message}");
            }
        }

        Debug.Log("Scene validation completed.");
    }
}

