using UnityEngine;
using UnityEngine.InputSystem;

public class CameraBehaviour : MonoBehaviour
{
    public float sens = 0.1f;
    public float rotX;
    public float rotY;
    public float funcA = 1.5f;
    public float funcBy = 0.2f;
    public float funcBx = 0.3f;


    void Start()
    {
        Cursor.visible = false;
        Cursor.lockState = CursorLockMode.Locked;
        rotX = transform.eulerAngles.x;
        rotY = transform.eulerAngles.y;
    }

    void Update()
        {
        Vector2 mouseDelta = Mouse.current.delta.ReadValue();
        Vector3 localEuler = transform.localEulerAngles;

        float xLook = transform.localEulerAngles.x;
        if (xLook > 180f) xLook = Mathf.Abs(xLook - 360f);
        float newSensX = sens * Mathf.Pow(funcA, -(xLook) * funcBx);
        if ((transform.localEulerAngles.x > 180 && mouseDelta.y < 0) || (transform.localEulerAngles.x < 180 && mouseDelta.y > 0))
        {
            newSensX = sens;
        }

        float yLook = transform.localEulerAngles.y;
        if (yLook > 180f) yLook = Mathf.Abs(yLook - 360f);
        float newSensY = sens * Mathf.Pow(funcA , -(yLook) * funcBy);
        if ((transform.localEulerAngles.y > 180 && mouseDelta.x > 0) || (transform.localEulerAngles.y < 180 && mouseDelta.x < 0))
        {
            newSensY = sens;
        }

        rotY += mouseDelta.x * newSensY;
        rotX -= mouseDelta.y * newSensX;

        rotX = Mathf.Clamp(rotX, -30f, 30f);
        rotY = Mathf.Clamp(rotY, -40f, 40f);
        

        transform.rotation = Quaternion.Euler(rotX, rotY, 0f);
    }

}
