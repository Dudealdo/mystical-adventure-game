using System.Diagnostics;
using UnityEditor;
using UnityEngine;

public class ImageBuilderUtility : EditorWindow
{
    [MenuItem("Tools/Run Image Builder")]
    public static void RunImageBuilder()
    {
        string scriptPath = "/home/dude/mystical_adventure_game/Assets/image_builder.sh";
        Process process = new Process();
        process.StartInfo.FileName = "bash";
        process.StartInfo.Arguments = scriptPath;
        process.StartInfo.RedirectStandardOutput = true;
        process.StartInfo.RedirectStandardError = true;
        process.StartInfo.UseShellExecute = false;
        process.StartInfo.CreateNoWindow = true;

        process.OutputDataReceived += (sender, args) => Debug.Log(args.Data);
        process.ErrorDataReceived += (sender, args) => Debug.LogError(args.Data);

        try
        {
            process.Start();
            process.BeginOutputReadLine();
            process.BeginErrorReadLine();
            process.WaitForExit();

            if (process.ExitCode == 0)
            {
                Debug.Log("Image Builder executed successfully.");
            }
            else
            {
                Debug.LogError("Image Builder failed.");
            }
        }
        catch (System.Exception ex)
        {
            Debug.LogError("Error running Image Builder: " + ex.Message);
        }
    }
}

