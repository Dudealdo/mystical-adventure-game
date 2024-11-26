using UnityEngine;

public class GameExitManager : MonoBehaviour
{
    // Update is called once per frame
    void Update()
    {
        // Exit the game when the player presses the "Escape" key (or you can choose another key)
        if (Input.GetKeyDown(KeyCode.Escape))
        {
            QuitGame();
        }
    }

    // Method to quit the game
    public void QuitGame()
    {
        // If we are running in the Unity editor, stop the play mode
        #if UNITY_EDITOR
        UnityEditor.EditorApplication.isPlaying = false;
        #else
        // Quit the application in a built game
        Application.Quit();
        #endif

        Debug.Log("Game is quitting...");  // Optional: log for feedback in the console
    }
}

