using UnityEditor;
using UnityEngine;

namespace MyGameAutomation
{
    public class DebugWindow : EditorWindow
    {
        [MenuItem("Tools/Debug/Automation Utilities")]
        public static void ShowWindow()
        {
            GetWindow<DebugWindow>("Automation Utilities");
        }

        private void OnGUI()
        {
            GUILayout.Label("Automation Utilities", EditorStyles.boldLabel);

            if (GUILayout.Button("Refresh Assets"))
            {
                AutomationUtils.RefreshAssets();
            }
        }
    }
}

