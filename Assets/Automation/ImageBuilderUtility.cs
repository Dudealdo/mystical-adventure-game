using System.Diagnostics;
using UnityEditor;
using UnityEngine;

public class ImageBuilderUtility : EditorWindow
{
    [MenuItem("Tools/Automation/Run Image Builder Utility")]
    public static void RunImageBuilder()
    {
        string scriptPath = "/home/dude/project_workspace/mystical_adventure_game/Assets/Automation/image_builder.sh"; // Update the path

        Process process = new Process();
        process.StartInfo.FileName = "bash";
        process.StartInfo.Arguments = scriptPath;
        process.StartInfo.RedirectStandardOutput = true;
        process.StartInfo.RedirectStandardError = true;
        process.StartInfo.UseShellExecute = false;
        process.StartInfo.CreateNoWindow = true;

        process.OutputDataReceived += (sender, args) =>
{
    if (!string.IsNullOrEmpty(args.Data))
    {
        UnityEngine.Debug.Log("[ImageBuilder] " + args.Data);
    }
    else
    {
        UnityEngine.Debug.LogWarning("[ImageBuilder] Empty output received.");
    }
};

process.ErrorDataReceived += (sender, args) =>
{
    if (!string.IsNullOrEmpty(args.Data))
    {
        UnityEngine.Debug.LogError("[ImageBuilder Error] " + args.Data);
    }
    else
    {
        UnityEngine.Debug.LogWarning("[ImageBuilder Error] Empty error received.");
    }
};

        try
        {
            process.Start();
            process.BeginOutputReadLine();
            process.BeginErrorReadLine();
            process.WaitForExit();

            if (process.ExitCode == 0)
            {
                UnityEngine.Debug.Log("Image Builder executed successfully.");
            }
            else
            {
                UnityEngine.Debug.LogError("Image Builder failed.");
            }
        }
        catch (System.Exception ex)
        {
            UnityEngine.Debug.LogError("Error running Image Builder: " + ex.Message);
        }
    }
}

