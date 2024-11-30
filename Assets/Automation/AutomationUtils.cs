using UnityEditor;

namespace MyGameAutomation
{
    public static class AutomationUtils
    {
        public static void RefreshAssets()
        {
            AssetDatabase.Refresh();
            UnityEngine.Debug.Log("Asset database refreshed successfully.");
        }
    }
}

