using UnityEngine;

public class AIController : MonoBehaviour
{
    public enum AIState { Idle, Patrolling, Attacking, Fleeing }
    public AIState currentState = AIState.Idle;

    private void Start()
    {
        SwitchState(AIState.Idle);
    }

    private void Update()
    {
        switch (currentState)
        {
            case AIState.Idle:
                HandleIdle();
                break;
            case AIState.Patrolling:
                HandlePatrolling();
                break;
            case AIState.Attacking:
                HandleAttacking();
                break;
            case AIState.Fleeing:
                HandleFleeing();
                break;
        }
    }

    public void SwitchState(AIState newState)
    {
        currentState = newState;
    }

    private void HandleIdle()
    {
        // Implement idle behavior (e.g., stand still)
        Debug.Log("AI is idle.");
    }

    private void HandlePatrolling()
    {
        // Implement patrolling behavior (e.g., move along a path)
        Debug.Log("AI is patrolling.");
    }

    private void HandleAttacking()
    {
        // Implement attacking behavior
        Debug.Log("AI is attacking.");
    }

    private void HandleFleeing()
    {
        // Implement fleeing behavior
        Debug.Log("AI is fleeing.");
    }
}

