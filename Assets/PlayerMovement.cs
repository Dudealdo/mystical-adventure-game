using UnityEngine;

public class PlayerMovement : MonoBehaviour
{
    public float moveSpeed = 5f;  // Speed of movement
    public float jumpForce = 5f;  // Force applied for jumping
    private Rigidbody rb;         // Reference to the Rigidbody component

    void Start()
    {
        rb = GetComponent<Rigidbody>();

        // Check if the Rigidbody component is attached
        if (rb == null)
        {
            Debug.LogError("No Rigidbody attached to the player. Please add a Rigidbody component.");
            return;
        }
    }

    void Update()
    {
        if (rb == null) return; // Prevent any further actions if Rigidbody is not assigned

        // Get player input for horizontal and vertical movement
        float moveHorizontal = Input.GetAxis("Horizontal");
        float moveVertical = Input.GetAxis("Vertical");

        // Calculate movement vector
        Vector3 movement = new Vector3(moveHorizontal, 0.0f, moveVertical) * moveSpeed;

        // Apply movement to the player's position
        rb.MovePosition(transform.position + movement * Time.deltaTime);

        // Check for jump input
        if (Input.GetButtonDown("Jump") && Mathf.Abs(rb.linearVelocity.y) < 0.01f)
        {
            rb.AddForce(Vector3.up * jumpForce, ForceMode.Impulse);
        }
    }
}

