using System.Diagnostics; // Required for Process
using UnityEditor;
using UnityEngine;

public class LoadHandlerManager : EditorWindow
{
    private const string ScriptPath = "Assets/Automation/load_handler.sh"; // Path relative to Unity project
    private static readonly string AbsoluteScriptPath = Application.dataPath + "/Automation/load_handler.sh"; // Absolute path

    [MenuItem("Tools/Automation/Run Load Handler")]
    public static void RunLoadHandler()
    {
        // Check if the script exists
        if (!System.IO.File.Exists(AbsoluteScriptPath))
        {
            UnityEngine.Debug.LogError($"[LoadHandler Error] Script not found at {AbsoluteScriptPath}. Ensure the file exists.");
            return;
        }

        // Configure and initialize the process
        Process process = new Process
        {
            StartInfo = new ProcessStartInfo
            {
                FileName = "bash", // Shell to execute script
                Arguments = AbsoluteScriptPath, // Pass the script path as an argument
                RedirectStandardOutput = true, // Capture standard output
                RedirectStandardError = true, // Capture error output
                UseShellExecute = false, // Ensure compatibility with cross-platform processes
                CreateNoWindow = true // Hide shell window during execution
            }
        };

        // Attach output and error handlers
        process.OutputDataReceived += (sender, args) =>
        {
            if (!string.IsNullOrEmpty(args.Data))
                UnityEngine.Debug.Log($"[LoadHandler] {args.Data}");
        };

        process.ErrorDataReceived += (sender, args) =>
        {
            if (!string.IsNullOrEmpty(args.Data))
                UnityEngine.Debug.LogError($"[LoadHandler Error] {args.Data}");
        };

        // Try executing the process
        try
        {
            EditorUtility.DisplayProgressBar("Load Handler", "Executing LoadHandler script...", 0.5f);

            process.Start(); // Start the process
            process.BeginOutputReadLine(); // Begin reading output
            process.BeginErrorReadLine(); // Begin reading errors

            if (!process.WaitForExit(60000)) // Wait for up to 60 seconds
            {
                UnityEngine.Debug.LogError("[LoadHandler Error] Process timed out.");
                process.Kill(); // Force stop
            }

            if (process.ExitCode == 0)
            {
                UnityEngine.Debug.Log("[LoadHandler] LoadHandler executed successfully.");
            }
            else
            {
                UnityEngine.Debug.LogError($"[LoadHandler Error] Exit Code: {process.ExitCode}, Script Path: {AbsoluteScriptPath}");
            }
        }
        catch (System.Exception ex)
        {
            UnityEngine.Debug.LogError($"[LoadHandler Error] Exception occurred: {ex.Message}");
        }
        finally
        {
            EditorUtility.ClearProgressBar();
        }
    }

    [MenuItem("Tools/Automation/Validate Script Path")]
    public static void ValidateScriptPath()
    {
        if (System.IO.File.Exists(AbsoluteScriptPath))
        {
            UnityEngine.Debug.Log($"[LoadHandler] Script found at: {AbsoluteScriptPath}");
        }
        else
        {
            UnityEngine.Debug.LogError($"[LoadHandler Error] Script not found at: {AbsoluteScriptPath}");
        }
    }
}

