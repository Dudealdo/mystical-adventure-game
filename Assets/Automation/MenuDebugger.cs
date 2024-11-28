using UnityEditor;
using UnityEngine;

public class MenuDebugger
{
    [MenuItem("Tools/Debug/List Menu Items")]
    public static void ListMenuItems()
    {
        Debug.Log("Menu debugging is not natively supported in Unity's public API.");

        Debug.Log("If you are experiencing issues with menu items, ensure that:");
        Debug.Log("- [MenuItem] attributes have unique paths.");
        Debug.Log("- Scripts are compiled without errors.");
        Debug.Log("- Scripts with [MenuItem] are in the correct folder (Editor).");
    }
}

