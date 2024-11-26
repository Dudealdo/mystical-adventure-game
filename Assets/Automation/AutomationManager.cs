using UnityEditor;
using UnityEngine;

public class AutomationManager : EditorWindow
{
    [MenuItem("Tools/Automation/Run Full Automation")]
    public static void RunFullAutomation()
    {
        Debug.Log("Starting Full Automation...");
        
        LoadHandlerManager.RunLoadHandler();
        ImageBuilderManager.RunImageBuilder();

        Debug.Log("Full Automation completed.");
    }
}

