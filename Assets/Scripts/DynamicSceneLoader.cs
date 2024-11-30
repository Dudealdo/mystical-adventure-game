using UnityEngine;
using UnityEngine.SceneManagement;
using System.Collections.Generic;

public class DynamicSceneLoader : MonoBehaviour
{
    public Transform player; // Reference to the player's transform
    public string[] sceneNames; // List of scenes to manage
    public float loadDistance = 50f; // Distance at which scenes should be loaded
    public float unloadDistance = 70f; // Distance at which scenes should be unloaded
    public float updateInterval = 0.5f; // Interval to check for scene loading/unloading (in seconds)

    private float timeSinceLastUpdate = 0f; // Timer to track the update interval
    private Dictionary<string, bool> scenePool = new Dictionary<string, bool>(); // Scene pooling dictionary

    private void Start()
    {
        // Initialize the scene pool with all scenes set as not loaded
        foreach (string sceneName in sceneNames)
        {
            scenePool[sceneName] = false;
        }
    }

    private void Update()
    {
        // Increment the time counter
        timeSinceLastUpdate += Time.deltaTime;

        // Only update scene loading/unloading every `updateInterval` seconds
        if (timeSinceLastUpdate >= updateInterval)
        {
            timeSinceLastUpdate = 0f; // Reset the timer

            // Iterate through all scenes
            foreach (string sceneName in sceneNames)
            {
                // Calculate the distance between the player and the scene
                float distanceToPlayer = Vector3.Distance(player.position, GetScenePosition(sceneName));

                // Log the distance to help with debugging
                Debug.Log($"[INFO] Distance to '{sceneName}': {distanceToPlayer} meters");

                // Load or unload scenes based on the distance
                if (distanceToPlayer < loadDistance && !scenePool[sceneName])
                {
                    LoadScene(sceneName);
                }
                else if (distanceToPlayer > unloadDistance && scenePool[sceneName])
                {
                    UnloadScene(sceneName);
                }
            }
        }
    }

    private void LoadScene(string sceneName)
    {
        if (!scenePool[sceneName])
        {
            Debug.Log($"[INFO] Attempting to load scene: {sceneName}");

            // Load the scene asynchronously
            SceneManager.LoadSceneAsync(sceneName, LoadSceneMode.Additive).completed += (AsyncOperation op) =>
            {
                if (op.isDone) // Check if loading was successful
                {
                    scenePool[sceneName] = true;
                    Debug.Log($"[INFO] Scene '{sceneName}' loaded successfully.");
                }
                else
                {
                    Debug.LogError($"[ERROR] Failed to load scene '{sceneName}'.");
                }
            };
        }
    }

    private void UnloadScene(string sceneName)
    {
        if (scenePool[sceneName])
        {
            Debug.Log($"[INFO] Attempting to unload scene: {sceneName}");

            // Unload the scene asynchronously
            SceneManager.UnloadSceneAsync(sceneName).completed += (AsyncOperation op) =>
            {
                if (op.isDone) // Check if unloading was successful
                {
                    scenePool[sceneName] = false;
                    Debug.Log($"[INFO] Scene '{sceneName}' unloaded successfully.");
                }
                else
                {
                    Debug.LogError($"[ERROR] Failed to unload scene '{sceneName}'.");
                }
            };
        }
    }

    private Vector3 GetScenePosition(string sceneName)
    {
        // Placeholder function to get the position of a scene
        // Replace this with real-world scene positions based on your game's world
        switch (sceneName)
        {
            case "BasicExplorationScene":
                return new Vector3(0, 0, 0);
            case "PuzzleRoomScene":
                return new Vector3(100, 0, 100);
            case "EncounterZoneScene":
                return new Vector3(-100, 0, -100);
            default:
                return Vector3.zero;
        }
    }
}

