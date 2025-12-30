using UnityEngine;
using System.Collections;

public class EmmisionScript : MonoBehaviour
{
    public Material material;
    public float unitTime = 0.2f;
    public float bloomMultiplier = 0.5f;
    public enum MorseMessage
    {
        RAND1,
        RAND2,
        RADIO
    }
    public MorseMessage message;

    void Start()
    {
        StartCoroutine(RADIO());
    }

    IEnumerator RADIO()
    {
        while (true)
        {
            
            yield return Dot();
            yield return Dot();
            yield return Dot();

            yield return LetterGap();

            yield return Dash();
            yield return Dash();
            yield return Dash();

            yield return LetterGap();

            yield return Dot();
            yield return Dot();
            yield return Dot();

            yield return WordGap();
        }
    }

    IEnumerator Dot()
    {
        EmissionOn();
        yield return new WaitForSeconds(unitTime);
        EmissionOff();
        yield return new WaitForSeconds(unitTime);
    }

    IEnumerator Dash()
    {
        EmissionOn();
        yield return new WaitForSeconds(unitTime * 3f);
        EmissionOff();
        yield return new WaitForSeconds(unitTime);
    }

    IEnumerator LetterGap()
    {
        yield return new WaitForSeconds(unitTime * 2f);
    }

    IEnumerator WordGap()
    {
        yield return new WaitForSeconds(unitTime * 4f);
    }

    void EmissionOn()
    {
        material.EnableKeyword("_EMISSION");
        material.SetColor("_EmissionColor", Color.white * bloomMultiplier);
    }

    void EmissionOff()
    {
        material.SetColor("_EmissionColor", Color.black);
    }
}