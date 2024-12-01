using UnityEditor;
using UnityEngine;

namespace MysticalAdventure
{
    public class AssetManager
    {
        public static void GenerateAssets()
        {
            Debug.Log("Starting asset generation...");

            string directory = "Assets/GeneratedMaterials";

            if (!AssetDatabase.IsValidFolder(directory))
            {
                AssetDatabase.CreateFolder("Assets", "GeneratedMaterials");
            }

            Material newMaterial = new Material(Shader.Find("Standard"));
            newMaterial.color = Color.green;

            string materialPath = $"{directory}/NewMaterial.mat";
            AssetDatabase.CreateAsset(newMaterial, materialPath);
            AssetDatabase.SaveAssets();

            Debug.Log("Asset generation completed successfully.");
        }
    }
}

