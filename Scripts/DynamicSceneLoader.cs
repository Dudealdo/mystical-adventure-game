// DynamicSceneLoader.cs
using UnityEngine;
using UnityEngine.SceneManagement;

public class DynamicSceneLoader : MonoBehaviour
{
    public Transform player; // Reference to the player's transform
    public string[] sceneNames; // List of scenes to manage
    public float loadDistance = 50f; // Distance at which scenes should be loaded
    public float unloadDistance = 70f; // Distance at which scenes should be unloaded

    private void Update()
    {
        foreach (string sceneName in sceneNames)
        {
            float distanceToPlayer = Vector3.Distance(player.position, GetScenePosition(sceneName));

            if (distanceToPlayer < loadDistance && !SceneManager.GetSceneByName(sceneName).isLoaded)
            {
                LoadScene(sceneName);
            }
            else if (distanceToPlayer > unloadDistance && SceneManager.GetSceneByName(sceneName).isLoaded)
            {
                UnloadScene(sceneName);
            }
        }
    }

    private void LoadScene(string sceneName)
    {
        if (!SceneManager.GetSceneByName(sceneName).isLoaded)
        {
            SceneManager.LoadSceneAsync(sceneName, LoadSceneMode.Additive);
            Debug.Log($"Loading scene: {sceneName}");
        }
    }

    private void UnloadScene(string sceneName)
    {
        if (SceneManager.GetSceneByName(sceneName).isLoaded)
        {
            SceneManager.UnloadSceneAsync(sceneName);
            Debug.Log($"Unloading scene: {sceneName}");
        }
    }

    private Vector3 GetScenePosition(string sceneName)
    {
        // Placeholder function to get the position of a scene
        // In actual implementation, you should return the position of the scene boundary or a point of interest
        // For now, let's return a mock position
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

