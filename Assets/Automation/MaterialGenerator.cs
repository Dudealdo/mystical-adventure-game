using UnityEditor;
using UnityEngine;

namespace MyGameAutomation
{
    public class MaterialGenerator
    {
        [MenuItem("Tools/Generate Materials")]
        public static void GenerateMaterials()
        {
            string directory = "Assets/GeneratedMaterials";

            if (!AssetDatabase.IsValidFolder(directory))
            {
                AssetDatabase.CreateFolder("Assets", "GeneratedMaterials");
            }

            Material newMaterial = new Material(Shader.Find("Standard"));
            newMaterial.color = Color.blue;

            string materialPath = $"{directory}/NewMaterial.mat";
            AssetDatabase.CreateAsset(newMaterial, materialPath);
            AssetDatabase.SaveAssets();

            Debug.Log("Material generated successfully at " + materialPath + "!");
        }
    }
}

