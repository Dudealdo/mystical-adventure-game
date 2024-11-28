using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using System.IO;

namespace MyGameAutomation
{
    public class ProceduralSceneBuilder : EditorWindow
    {
        private string imagesPath = "Assets/rendered_images";
        private float planeSpacing = 10f;

        [MenuItem("Tools/Scene Automation/Build Procedural Scene")]
        public static void ShowWindow()
        {
            GetWindow<ProceduralSceneBuilder>("Procedural Scene Builder");
        }

        private void OnGUI()
        {
            GUILayout.Label("Procedural Scene Builder", EditorStyles.boldLabel);

            imagesPath = EditorGUILayout.TextField("Images Path", imagesPath);
            planeSpacing = EditorGUILayout.FloatField("Plane Spacing", planeSpacing);

            if (GUILayout.Button("Build Procedural Scene"))
            {
                BuildScene();
            }
        }

        private void BuildScene()
        {
            // Create a new scene
            EditorSceneManager.NewScene(NewSceneSetup.DefaultGameObjects, NewSceneMode.Single);
            Debug.Log("Created a new scene.");

            if (!Directory.Exists(imagesPath))
            {
                Debug.LogError($"Image directory not found: {imagesPath}");
                return;
            }

            string[] imageFiles = Directory.GetFiles(imagesPath, "*.png");
            if (imageFiles.Length == 0)
            {
                Debug.LogError("No images found in the directory.");
                return;
            }

            Debug.Log($"Found {imageFiles.Length} images. Generating planes...");

            int gridSize = Mathf.CeilToInt(Mathf.Sqrt(imageFiles.Length));
            for (int i = 0; i < imageFiles.Length; i++)
            {
                string imagePath = imageFiles[i];
                Texture2D texture = AssetDatabase.LoadAssetAtPath<Texture2D>(imagePath);

                if (texture == null)
                {
                    Debug.LogWarning($"Failed to load texture: {imagePath}");
                    continue;
                }

                GameObject plane = GameObject.CreatePrimitive(PrimitiveType.Plane);
                plane.name = $"Plane_{Path.GetFileNameWithoutExtension(imagePath)}";

                Material material = new Material(Shader.Find("Standard"));
                material.mainTexture = texture;
                plane.GetComponent<Renderer>().material = material;

                int row = i / gridSize;
                int col = i % gridSize;
                plane.transform.position = new Vector3(col * planeSpacing, 0, row * planeSpacing);
            }

            Debug.Log("All planes created.");

            GameObject light = new GameObject("Directional Light");
            Light directionalLight = light.AddComponent<Light>();
            directionalLight.type = LightType.Directional;
            light.transform.rotation = Quaternion.Euler(50, -30, 0);

            Camera.main.transform.position = new Vector3(gridSize * planeSpacing / 2, gridSize * planeSpacing / 2, -gridSize * planeSpacing / 1.5f);
            Camera.main.transform.LookAt(new Vector3(gridSize * planeSpacing / 2, 0, gridSize * planeSpacing / 2));

            string scenePath = "Assets/Scenes/ProceduralScene.unity";
            Directory.CreateDirectory("Assets/Scenes");
            EditorSceneManager.SaveScene(EditorSceneManager.GetActiveScene(), scenePath);
            Debug.Log($"Scene saved at: {scenePath}");

            AssetDatabase.Refresh();
            Debug.Log("AssetDatabase refreshed.");
        }
    }
}

