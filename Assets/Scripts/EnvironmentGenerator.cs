using UnityEngine;
using Managers;  // Add this line to access PlayerManager in the Managers namespace

public class EnvironmentGenerator : MonoBehaviour
{
    public PlayerManager playerManager;  // Reference to PlayerManager

    private void Start()
    {
        GenerateEnvironment();
    }

    public void GenerateEnvironment()
    {
        switch (playerManager.currentPath)
        {
            case PlayerManager.PlayerPath.Healer:
                Debug.Log("Generating Healer environment: Lush, plant-filled.");
                break;
            case PlayerManager.PlayerPath.Innovator:
                Debug.Log("Generating Innovator environment: Futuristic.");
                break;
            case PlayerManager.PlayerPath.FreeSpirit:
                Debug.Log("Generating Free Spirit environment: Open and free.");
                break;
            case PlayerManager.PlayerPath.Visionary:
                Debug.Log("Generating Visionary environment: Surreal and cosmic.");
                break;
            default:
                break;
        }
    }
}

