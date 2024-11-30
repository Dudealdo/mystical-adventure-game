using UnityEditor;
using UnityEngine;
using System.Diagnostics;

public class MasterAssetGenerator : EditorWindow
{
    [MenuItem("Tools/Run Master Asset Generator")]
    public static void RunAssetGenerator()
    {
        string scriptPath = "/home/dude/project_workspace/mystical_adventure_game/Assets/Automation/master_asset_generator.sh";

        Process process = new Process();
        process.StartInfo.FileName = "bash";
        process.StartInfo.Arguments = scriptPath;
        process.StartInfo.RedirectStandardOutput = true;
        process.StartInfo.RedirectStandardError = true;
        process.StartInfo.UseShellExecute = false;
        process.StartInfo.CreateNoWindow = true;

        process.OutputDataReceived += (sender, args) => UnityEngine.Debug.Log("[MasterAssetGenerator] " + args.Data);
        process.ErrorDataReceived += (sender, args) => UnityEngine.Debug.LogError("[MasterAssetGenerator Error] " + args.Data);

        try
        {
            process.Start();
            process.BeginOutputReadLine();
            process.BeginErrorReadLine();
            process.WaitForExit();

            if (process.ExitCode == 0)
            {
                UnityEngine.Debug.Log("Master Asset Generator executed successfully.");
            }
            else
            {
                UnityEngine.Debug.LogError("Master Asset Generator encountered an issue.");
            }
        }
        catch (System.Exception ex)
        {
            UnityEngine.Debug.LogError("Error running Master Asset Generator: " + ex.Message);
        }
    }
}

