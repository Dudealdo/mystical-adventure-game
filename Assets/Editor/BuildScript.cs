using UnityEditor; // For BuildPipeline and related editor classes
using UnityEngine; // For Unity's Debug logging

namespace MysticalAdventure
{
    public static class BuildScript
    {
        [MenuItem("Build/Build Windows64")]
        public static void BuildWindows64()
        {
            string buildPath = "Builds/StandaloneWindows64";

            // Specify the scenes to include in the build
            string[] scenes = { "Assets/Scenes/ProceduralScene.unity" }; // Update paths as necessary

            // Start the build process
            BuildPipeline.BuildPlayer(
                scenes,
                buildPath,
                BuildTarget.StandaloneWindows64,
                BuildOptions.None
            );

            // Log a success message to the Unity console
            UnityEngine.Debug.Log($"Build completed successfully at {buildPath}");
        }
    }
}

