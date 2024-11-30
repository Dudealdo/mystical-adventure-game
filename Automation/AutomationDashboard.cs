using UnityEditor;
using UnityEngine;

namespace MyGameAutomation
{
    public class AutomationDashboard : EditorWindow
    {
        [MenuItem("Tools/Automation Dashboard")]
        public static void ShowWindow()
        {
            GetWindow<AutomationDashboard>("Automation Dashboard");
        }

        private void OnGUI()
        {
            GUILayout.Label("Automation Tools", EditorStyles.boldLabel);

            if (GUILayout.Button("Run Master Automation"))
            {
                RunScript("master_automation_manager.sh");
            }

            if (GUILayout.Button("Run Scene Creator"))
            {
                RunScript("scene_creator.sh");
            }

            if (GUILayout.Button("Run Scene Recycler"))
            {
                RunScript("scene_recycling.sh");
            }

            if (GUILayout.Button("View Logs"))
            {
                OpenLogs();
            }
        }

        private void RunScript(string scriptName)
        {
            string scriptPath = $"{Application.dataPath}/Automation/Scripts/{scriptName}";
            System.Diagnostics.Process.Start("bash", scriptPath);
        }

        private void OpenLogs()
        {
            string logsPath = $"{Application.dataPath}/Automation/Logs/";
            System.Diagnostics.Process.Start("xdg-open", logsPath);
        }
    }
}

