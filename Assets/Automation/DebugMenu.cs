using UnityEditor;
using UnityEngine;

namespace MyGameAutomation
{
    public static class DebugMenu
    {
        [MenuItem("Tools/Debug/Refresh Assets")]
        public static void RefreshAssets()
        {
            Debug.Log("Refreshing Unity Asset Database...");
            AssetDatabase.Refresh();
            Debug.Log("Asset Database refreshed successfully.");
        }
    }
}

