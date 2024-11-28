using System.Diagnostics;
using UnityEditor;
using UnityEngine;

public class ImageBuilderManager : EditorWindow
{
    [MenuItem("Tools/Automation/Run Image Builder Manager")]
    public static void RunImageBuilder()
    {
        string scriptPath = Application.dataPath + "/Automation/image_builder.sh"; // Adjust the path as needed

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
                UnityEngine.Debug.Log("[ImageBuilder] " + args.Data);
        };

        process.ErrorDataReceived += (sender, args) =>
        {
            if (!string.IsNullOrEmpty(args.Data))
                UnityEngine.Debug.LogError("[ImageBuilder Error] " + args.Data);
        };

        try
        {
            process.Start();
            process.BeginOutputReadLine();
            process.BeginErrorReadLine();
            process.WaitForExit();

            if (process.ExitCode == 0)
            {
                UnityEngine.Debug.Log("ImageBuilder executed successfully.");
            }
            else
            {
                UnityEngine.Debug.LogError("ImageBuilder encountered an issue.");
            }
        }
        catch (System.Exception ex)
        {
            UnityEngine.Debug.LogError("Error running ImageBuilder: " + ex.Message);
        }
    }
}

