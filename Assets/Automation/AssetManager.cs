using UnityEditor;
using UnityEngine;

namespace MysticalAdventure
{
    public static class AssetManager
    {
        public static void GenerateAssets()
        {
            Debug.Log("[AssetManager] Generating assets...");
            
            // Create the folder for generated materials
            string folderPath = "Assets/GeneratedMaterials";
            if (!AssetDatabase.IsValidFolder(folderPath))
            {
                AssetDatabase.CreateFolder("Assets", "GeneratedMaterials");
            }

            // Create a new material as an example
            Material newMaterial = new Material(Shader.Find("Standard"));
            newMaterial.color = Color.green;
            string materialPath = $"{folderPath}/GeneratedMaterial.mat";

            AssetDatabase.CreateAsset(newMaterial, materialPath);
            AssetDatabase.SaveAssets();

            Debug.Log("[AssetManager] Assets generated successfully at " + materialPath);
        }
    }
}

