using UnityEngine;

public class CreateGlowingOrb : MonoBehaviour
{
    public GameObject orbPrefab;
    public Vector3 spawnPosition;
    public float glowIntensity = 1.0f;

    void Start()
    {
        if (orbPrefab != null)
        {
            GameObject orb = Instantiate(orbPrefab, spawnPosition, Quaternion.identity);
            orb.GetComponent<Renderer>().material.SetFloat("_Glow", glowIntensity);
        }
    }
}

