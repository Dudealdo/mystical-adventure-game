using UnityEngine;

public class AIController : MonoBehaviour
{
    public enum AIState { Idle, Patrolling, Attacking, Fleeing }
    public AIState currentState = AIState.Idle;

    private void Start()
    {
        SwitchState(AIState.Idle);
    }

    // Custom public method to update AI (instead of Update())
    public void DoAIUpdate()
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

    // This method changes the AI's state
    public void SwitchState(AIState newState)
    {
        currentState = newState;
    }

    // Handle each state with custom behavior
    private void HandleIdle()
    {
        Debug.Log("AI is idle.");
    }

    private void HandlePatrolling()
    {
        Debug.Log("AI is patrolling.");
    }

    private void HandleAttacking()
    {
        Debug.Log("AI is attacking.");
    }

    private void HandleFleeing()
    {
        Debug.Log("AI is fleeing.");
    }
}

