using UnityEngine;

namespace Managers  // Ensure PlayerManager is in the Managers namespace
{
    public class PlayerManager : MonoBehaviour
    {
        // Enum for Path Types
        public enum PlayerPath
        {
            None,
            Healer,
            Innovator,
            FreeSpirit,
            Visionary
        }

        // Current path the player is on
        public PlayerPath currentPath = PlayerPath.None;

        // A field to hold the current path effect
        private string pathName;

        // Start method that sets the player path and applies effects
        private void Start()
        {
            // Initialize path when game starts
            SetPlayerPath(currentPath);
        }

        // This method sets the path based on the PlayerPath enum and applies the corresponding effect
        public void SetPlayerPath(PlayerPath path)
        {
            currentPath = path;

            // Set path name for the current path
            switch (currentPath)
            {
                case PlayerPath.Healer:
                    pathName = "Healer";
                    ApplyPathEffect("Healing power increased!");
                    break;
                case PlayerPath.Innovator:
                    pathName = "Innovator";
                    ApplyPathEffect("Innovation unlocked!");
                    break;
                case PlayerPath.FreeSpirit:
                    pathName = "Free Spirit";
                    ApplyPathEffect("Freedom increased!");
                    break;
                case PlayerPath.Visionary:
                    pathName = "Visionary";
                    ApplyPathEffect("New visions unlocked!");
                    break;
                default:
                    pathName = "None";
                    Debug.Log("No path selected.");
                    break;
            }
        }

        // This method applies the specific effects based on the player's path
        private void ApplyPathEffect(string effectMessage)
        {
            Debug.Log($"Path: {pathName} activated. Effect: {effectMessage}");
        }

        // A helper method to get the current path's name (optional)
        public string GetCurrentPath()
        {
            return pathName;
        }
    }
}

