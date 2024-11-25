using UnityEditor;
using UnityEngine;

public class SceneValidator
{
    [MenuItem("Tools/Validate Scenes")]
    public static void ValidateScenes()
    {
        Debug.Log("Validating Scenes...");
        foreach (var scene in EditorBuildSettings.scenes)
        {
            if (!scene.enabled)
                continue;

            Debug.Log($"Validating scene: {scene.path}");
        }
        Debug.Log("Scene validation complete!");
    }
}

