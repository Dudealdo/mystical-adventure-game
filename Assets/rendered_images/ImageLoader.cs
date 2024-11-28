using System.IO;
using UnityEngine;

public class ImageLoader : MonoBehaviour
{
    public string imagesPath = "rendered_images"; // Relative path to the images folder
    public Renderer targetRenderer; // Assign a Renderer component to display the image (e.g., a quad)

    private string[] imageFiles;
    private int currentImageIndex = 0;

    void Start()
    {
        string fullPath = Path.Combine(Application.dataPath, imagesPath);

        if (!Directory.Exists(fullPath))
        {
            Debug.LogError($"Directory not found: {fullPath}");
            return;
        }

        // Get all image files from the folder
        imageFiles = Directory.GetFiles(fullPath, "*.png");

        if (imageFiles.Length == 0)
        {
            Debug.LogError("No images found in the specified folder.");
            return;
        }

        // Display the first image
        LoadImage(currentImageIndex);
    }

    void Update()
    {
        // Navigate images with arrow keys
        if (Input.GetKeyDown(KeyCode.RightArrow))
        {
            currentImageIndex = (currentImageIndex + 1) % imageFiles.Length;
            LoadImage(currentImageIndex);
        }
        else if (Input.GetKeyDown(KeyCode.LeftArrow))
        {
            currentImageIndex = (currentImageIndex - 1 + imageFiles.Length) % imageFiles.Length;
            LoadImage(currentImageIndex);
        }
    }

    private void LoadImage(int index)
    {
        if (index < 0 || index >= imageFiles.Length)
        {
            Debug.LogError("Index out of range for image files.");
            return;
        }

        string imagePath = imageFiles[index];
        Debug.Log($"Loading image: {imagePath}");

        // Load the image into a Texture2D
        byte[] imageData = File.ReadAllBytes(imagePath);
        Texture2D texture = new Texture2D(2, 2);
        texture.LoadImage(imageData);

        // Apply the texture to the Renderer
        if (targetRenderer != null)
        {
            targetRenderer.material.mainTexture = texture;
        }
        else
        {
            Debug.LogError("Target Renderer is not assigned.");
        }
    }
}

