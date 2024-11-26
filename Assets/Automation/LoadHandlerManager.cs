using System.Diagnostics;
using UnityEditor;
using UnityEngine;

public class LoadHandlerManager : EditorWindow
{
    [MenuItem("Tools/Automation/Run Load Handler")]
    public static void RunLoadHandler()
    {
        string scriptPath = "Assets/Automation/LoadHandler.sh"; // Adjust path if necessary

        Process process = new Process();
        process.StartInfo.FileName = "bash";
        process.StartInfo.Arguments = scriptPath;
        process.StartInfo.RedirectStandardOutput = true;
        process.StartInfo.RedirectStandardError = true;
        process.StartInfo.UseShellExecute = false;
        process.StartInfo.CreateNoWindow = true;

        process.OutputDataReceived += (sender, args) => Debug.Log("[LoadHandler] " + args.Data);
        process.ErrorDataReceived += (sender, args) => Debug.LogError("[LoadHandler Error] " + args.Data);

        try
        {
            process.Start();
            process.BeginOutputReadLine();
            process.BeginErrorReadLine();
            process.WaitForExit();

            if (process.ExitCode == 0)
            {
                Debug.Log("LoadHandler executed successfully.");
            }
            else
            {
                Debug.LogError("LoadHandler encountered an issue.");
            }
        }
        catch (System.Exception ex)
        {
            Debug.LogError("Error running LoadHandler: " + ex.Message);
        }
    }
}

