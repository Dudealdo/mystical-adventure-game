using UnityEngine;
using UnityEditor;
using UnityEditor.SceneManagement;  // Make sure this is here to access EditorSceneManager
using System.IO;  // Make sure this is for File.Exists

public class SceneValidator : EditorWindow
{
    private string scenePath = "";  // Store the scene path
    private bool validateOnSave = true;  // Option to validate scene when saved

    [MenuItem("Tools/Validate Scene")]
    public static void ShowWindow()
    {
        // Opens the editor window for scene validation
        GetWindow<SceneValidator>("Scene Validator");
    }

    private void OnGUI()
    {
        GUILayout.Label("Scene Validator", EditorStyles.boldLabel);

        // Create a text field for entering or selecting the scene path
        scenePath = EditorGUILayout.TextField("Scene Path", scenePath);

        if (GUILayout.Button("Validate Scene"))
        {
            ValidateScene();
        }

        // Option to automatically validate the scene when it is saved
        validateOnSave = EditorGUILayout.Toggle("Validate on Save", validateOnSave);

        // Instructions or additional info for the user
        EditorGUILayout.HelpBox("Va

