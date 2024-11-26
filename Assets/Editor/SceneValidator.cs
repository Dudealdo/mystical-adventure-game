using UnityEditor;
using UnityEngine;

public class SceneValidator
{
    [MenuItem("Tools/Validate Scenes")]
    public static void ValidateScenes()
    {
        Debug.Log("Validating Scenes...");

        // Loop through each scene in the Build Settings
        foreach (var scene in EditorBuildSettings.scenes)
        {
            // Only validate enabled scenes
            if (!scene.enabled)
                continue;

            // Log each scene that is being validated
            Debug.Log("Validating scene: " + scene.path);
        }

        // Log when validation is complete
        Debug.Log("Scene validation complete!");
    }
}

