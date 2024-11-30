using UnityEngine;

[CreateAssetMenu(fileName = "NewPathData", menuName = "Game/PathData", order = 1)]
public class PathData : ScriptableObject
{
    public string pathName;
    public string description;
    public Ability[] abilities; // List of abilities this path will unlock
}

[System.Serializable]
public class Ability
{
    public string abilityName;
    public string description;
    public Sprite icon;
}

