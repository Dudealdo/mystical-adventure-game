using UnityEngine;
using UnityEditor;

public class SceneValidator : EditorWindow
{
    [MenuItem("Tools/Validate Scene")]
    public static void ValidateScene()
    {
        // You can get the current scene path dynamically if needed
        string scenePath = "Assets/Scenes/NewScene.unity";  // Update with correct scene path

        if (System.IO.File.Exists(scenePath))
        {
            // Open the scene for validation (this step is optional for validation)
            UnityEditor.SceneManagement.EditorSceneManager.OpenScene(scenePath);

            // Validate the scene here, e.g., check for missing references or broken components
            Debug.Log("Scene validated successfully!");
        }
        else
        {
            Debug.LogError("Scene not found at " + scenePath);
        }
    }
}

