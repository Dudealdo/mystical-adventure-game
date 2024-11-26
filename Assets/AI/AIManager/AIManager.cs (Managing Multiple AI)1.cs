using UnityEngine;
using System.Collections.Generic;

public class AIManager : MonoBehaviour
{
    // List to store all AI agents (e.g., NPCs, enemies)
    public List<AIController> aiControllers;

    // Optionally, you can control states or group behaviors
    public bool allAIIdle = false;

    private void Start()
    {
        // Find all AI controllers in the scene and add them to the list
        aiControllers = new List<AIController>(FindObjectsByType<AIController>(FindObjectsSortMode.None));
    }

    private void Update()
    {
        // Update each AI in the list by calling DoAIUpdate() instead of Update()
        foreach (var ai in aiControllers)
        {
            ai.DoAIUpdate();  // Calls the public DoAIUpdate() method of each AI
        }

        // Optionally, handle bulk behavior logic here (e.g., make all AI switch to idle)
        if (allAIIdle)
        {
            SwitchAllAIState(AIController.AIState.Idle);
        }
    }

    // Method to switch the state of all AI agents at once
    public void SwitchAllAIState(AIController.AIState newState)
    {
        foreach (var ai in aiControllers)
        {
            ai.SwitchState(newState);  // Call the SwitchState method on each AI
        }
    }

    // Method to add a new AI controller to the list
    public void AddAIController(AIController newAI)
    {
        if (!aiControllers.Contains(newAI))
        {
            aiControllers.Add(newAI);
        }
    }

    // Method to remove an AI controller from the list
    public void RemoveAIController(AIController aiToRemove)
    {
        if (aiControllers.Contains(aiToRemove))
        {
            aiControllers.Remove(aiToRemove);
        }
    }
}

