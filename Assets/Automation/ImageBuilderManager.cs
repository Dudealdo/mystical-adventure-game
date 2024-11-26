using System.Diagnostics;
using UnityEditor;
using UnityEngine;

public class ImageBuilderManager : EditorWindow
{
    [MenuItem("Tools/Automation/Run Image Builder")]
    public static void RunImageBuilder()
    {
        string scriptPath = "Assets/Automation/image_builder.sh"; // Adjust path if necessary

        Process process = new Process();
        process.StartInfo.FileName = "bash";
        process.StartInfo.Arguments = scriptPath;
        process.StartInfo.RedirectStandardOutput = true;
        process.StartInfo.RedirectStandardError = true;
        process.StartInfo.UseShellExecute = false;
        process.StartInfo.CreateNoWindow = true;

        process.OutputDataReceived += (sender, args) => Debug.Log("[ImageBuilder] " + args.Data);
        process.ErrorDataReceived += (sender, args) => Debug.LogError("[ImageBuilder Error] " + args.Data);

        try
        {
            process.Start();
            process.BeginOutputReadLine();
            process.BeginErrorReadLine();
            process.WaitForExit();

            if (process.ExitCode == 0)
            {
                Debug.Log("ImageBuilder executed successfully.");
            }
            else
            {
                Debug.LogError("ImageBuilder encountered an issue.");
            }
        }
        catch (System.Exception ex)
        {
            Debug.LogError("Error running ImageBuilder: " + ex.Message);
        }
    }
}

